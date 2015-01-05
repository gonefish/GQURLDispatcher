//
//  GQSimpleResponder.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/1/4.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQSimpleResponder.h"
#import "NSURL+GQURLUtilities.h"
#import "GQURLViewController.h"

@implementation GQSimpleResponder

- (instancetype)initWithContainerViewController:(UIViewController *)aViewController alias:(NSString *)alias
{
    self = [super init];
    
    if (self) {
        _containerViewController = aViewController;
        _alias = [alias copy];
    }
    
    return self;
}

- (UIViewController *)viewControllerWithURL:(NSURL *)aURL object:(id)anObject
{
    NSString *className = [self.classNameMap objectForKey:[aURL gq_dispatchURLString]];
    
    if (className == nil) return nil;
    
    Class cls = NSClassFromString(className);
    
    UIViewController *newVC = nil;
    
    if ([cls isSubclassOfClass:[GQURLViewController class]]) {
        newVC = [[cls alloc] initWithURL:aURL withObject:anObject];
    } else if ([cls isSubclassOfClass:[UIViewController class]]) {
        newVC = [[cls alloc] init];
        
        if ([cls conformsToProtocol:@protocol(GQURLViewController)]) {
            [(id <GQURLViewController>)newVC updateWithURL:aURL withObject:anObject];
        }
    }
    
    return newVC;
}

@end
