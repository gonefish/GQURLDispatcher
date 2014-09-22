//
//  GQTabBarResponder.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQTabBarResponder.h"
#import "NSURL+GQURLUtilities.h"
#import "GQURLViewController.h"

NSString * const GQTabBarIndex = @"GQTabBarIndex";

@implementation GQTabBarResponder

- (id)initWithTabBarController:(UITabBarController *)aTabBarController
{
    self = [super init];
    
    if (self) {
        self.tabBarController = aTabBarController;
    }
    
    return self;
}

- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    NSString *selectedIndexString = [[aURL queryDictionary] objectForKey:GQTabBarIndex];
    
    if (selectedIndexString == nil) return NO;
    
    NSUInteger selectedIndex = [selectedIndexString integerValue];
    
    if ([[self.tabBarController viewControllers] count] >= 6
        && selectedIndex > 3) {
        return NO;
    } else {
        if (selectedIndex + 1 > [[self.tabBarController viewControllers] count]) {
            return NO;
        }
    }
    
    self.tabBarController.selectedIndex = selectedIndex;
    
    return YES;
}

@end
