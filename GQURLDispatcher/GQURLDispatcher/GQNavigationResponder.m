//
//  GQNavigationResponder.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQNavigationResponder.h"
#import "NSURL+GQURLUtilities.h"

@implementation GQNavigationResponder

- (id)initWithNavigationController:(UINavigationController *)aNavigationController alias:(NSString *)alias
{
    self = [super init];
    
    if (self) {
        _navigationController = aNavigationController;
        _alias = [alias copy];
    }
    
    return self;
}

- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    if (self.navigationController.tabBarController
        && self.navigationController.tabBarController.selectedViewController != self.navigationController) {
        return NO;
    }
    
    UIViewController *newVC = [self viewControllerWithURL:aURL withObject:anObject];
    
    if (newVC == nil) return NO;
    
    NSString *animated = [[aURL gq_queryDictionary] objectForKey:@"animated"];
    
    [self.navigationController pushViewController:newVC
                                         animated:animated ? [animated boolValue] : YES];
    
    return YES;
}

@end
