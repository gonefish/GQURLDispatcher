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
    
    if ([cls isSubclassOfClass:[UIViewController class]]) {
        newVC = [[cls alloc] init];
        
        if ([cls conformsToProtocol:@protocol(GQURLViewController)]) {
            [(id <GQURLViewController>)newVC updateWithURL:aURL object:anObject];
        }
    }
    
    return newVC;
}

- (void)setClassNameMap:(NSDictionary *)classNameMap
{
    @synchronized(self) {
        _classNameMap = [classNameMap copy];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        NSURL *aURL = nil;
        
        for (id url in [_classNameMap allKeys]) {
            aURL = [NSURL URLWithString:url];
            
            if (aURL) {
                [tmpArray addObject:aURL];
            }
        }
        
        if (self.responseURLs) {
            self.responseURLs = [self.responseURLs arrayByAddingObjectsFromArray:tmpArray];
        } else {
            self.responseURLs = tmpArray;
        }
    }
}

@end
