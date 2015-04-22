//
//  GQNavigationResponder.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQNavigationResponder.h"
#import "NSURL+GQURLUtilities.h"
#import "GQURLDispatcher.h"

@implementation GQNavigationResponder


- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    UINavigationController *navigationController = (UINavigationController *)self.containerViewController;
    
    if (navigationController.tabBarController
        && navigationController.tabBarController.selectedViewController != navigationController) {
        return NO;
    }
    
    UIViewController *newVC = [self viewControllerWithURL:aURL object:anObject];
    
    if (newVC == nil) return NO;
    
    NSString *animated = [[aURL gq_queryDictionary] objectForKey:@"animated"];
    
    [navigationController pushViewController:newVC
                                    animated:animated ? [animated boolValue] : YES];
    
    return YES;
}

@end

@implementation UINavigationController (GQURLDispatcher)

- (void)gq_addResponderWithAlias:(NSString *)aliasName completion:(void (^)(GQNavigationResponder *responder))completion
{
    GQNavigationResponder *responer =
    [[GQNavigationResponder alloc] initWithContainerViewController:self
                                                             alias:aliasName];
    
    if (completion) {
        completion(responer);
    }
    
    [[GQURLDispatcher sharedInstance] registerResponder:responer];
}

- (void)gq_removeResponderWithAlias:(NSString *)aliasName;
{
    id <GQURLResponder> responder = [[GQURLDispatcher sharedInstance] responderForAlias:aliasName];
    
    if (responder) {
        [[GQURLDispatcher sharedInstance] unregisterResponder:responder];
    }
}

@end