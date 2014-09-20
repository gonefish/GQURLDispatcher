//
//  GQTabBarResponder.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQTabBarResponder.h"
#import "NSURL+GQURLUtilities.h"
#import "GQURLViewController.h"

@implementation GQTabBarResponder

- (id)initWithTabBarController:(UITabBarController *)aTabBarController
{
    self = [super init];
    
    if (self) {
        self.tabBarController = aTabBarController;
    }
    
    return self;
}

- (void)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    __block UIViewController *selectVC = nil;
    
    [self.tabBarController.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        if ([obj conformsToProtocol:@protocol(GQURLViewController)]) {
            if ([aURL isSameToURL:[(id <GQURLViewController>)obj gqURL]]) {
                selectVC = obj;
                *stop = YES;
            }
        }
    }];
    
    if (selectVC) {
        self.tabBarController.selectedViewController = selectVC;
        
        [(id <GQURLViewController>)selectVC updateWithURL:aURL
                                               withObject:anObject];
    }
    
}

@end
