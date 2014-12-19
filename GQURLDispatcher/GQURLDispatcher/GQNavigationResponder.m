//
//  GQNavigationResponder.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQNavigationResponder.h"
#import "NSURL+GQURLUtilities.h"
#import "GQURLViewController.h"

@implementation GQNavigationResponder

- (id)initWithNavigationController:(UINavigationController *)aNavigationController
{
    self = [super init];
    
    if (self) {
        _navigationController = aNavigationController;
    }
    
    return self;
}

- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    if (self.navigationController.tabBarController
        && self.navigationController.tabBarController.selectedViewController != self.navigationController) {
        return NO;
    }
    
    NSString *className = [self.classNameMap objectForKey:[aURL dispatchURLString]];
    
    if (className == nil) return NO;
    
    Class cls = NSClassFromString(className);
    
    UIViewController *newVC = nil;
    
    if ([cls conformsToProtocol:@protocol(GQURLViewController)]) {
        newVC = [[cls alloc] initWithURL:aURL withObject:anObject];
    } else {
        newVC = [[cls alloc] init];
    }
    
    if (newVC == nil) return NO;
    
    NSString *animated = [[aURL queryDictionary] objectForKey:@"animated"];
    
    [self.navigationController pushViewController:newVC
                                         animated:animated ? [animated boolValue] : NO];
    
    return YES;
}

@end
