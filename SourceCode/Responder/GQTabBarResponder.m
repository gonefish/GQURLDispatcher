//
//  GQTabBarResponder.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQTabBarResponder.h"
#import "NSURL+GQURLUtilities.h"


@interface GQTabBarResponder ()


@end

@implementation GQTabBarResponder

- (id)initWithTabBarController:(UITabBarController *)aTabBarController URL:(NSURL *)aURL
{
    if (aTabBarController == nil
        || aURL == nil) {
        return nil;
    }
    
    self = [super init];
    
    if (self) {
        _tabBarController = aTabBarController;
        _responseURLs = @[aURL];
    }
    
    return self;
}

- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    NSString *selectedIndexValue = [[aURL gq_queryDictionary] objectForKey:@"selectedIndex"];
    
    if (selectedIndexValue == nil) return NO;
    
    NSUInteger selectedIndex = [selectedIndexValue integerValue];
    
    if (selectedIndex + 1 > [[self.tabBarController viewControllers] count]) {
        return NO;
    }
    
    self.tabBarController.selectedIndex = selectedIndex;
    
    return YES;
}

@end
