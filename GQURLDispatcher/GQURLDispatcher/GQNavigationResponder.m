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
        self.navigationController = aNavigationController;
    }
    
    return self;
}

- (void)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    NSString *className = [self.classNameMap objectForKey:[aURL dispatchURLString]];
    
    if (className == nil) return;
    
    Class cls = NSClassFromString(className);
    
    UIViewController *newVC = nil;
    
    if ([cls isSubclassOfClass:[GQURLViewController class]]) {
        newVC = [[cls alloc] initWithURL:aURL withObject:anObject];
    } else {
        newVC = [[cls alloc] init];
    }
    
    [self.navigationController pushViewController:newVC
                                         animated:NO];
}

@end
