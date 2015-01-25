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
        
        if (aViewController.storyboard) {
            _storyboard = aViewController.storyboard;
        }
    }
    
    return self;
}

- (UIViewController *)viewControllerWithURL:(NSURL *)aURL object:(id)anObject
{
    UIViewController *newVC = [self storyboardViewControllerWithURL:aURL object:anObject];
    
    if (newVC == nil) {
        newVC = [self nibViewControllerWithURL:aURL object:anObject];
    }
    
    if ([newVC conformsToProtocol:@protocol(GQURLViewController)]) {
        [(id <GQURLViewController>)newVC updateWithURL:aURL object:anObject];
    }
    
    return newVC;
}

- (void)setStoryboardIdentifierMap:(NSDictionary *)storyboardIdentifierMap
{
    @synchronized(self) {
        _storyboardIdentifierMap = [storyboardIdentifierMap copy];
        
        [self addResponseURLsWithArray:[_storyboardIdentifierMap allKeys]];
    }
}

- (void)setClassNameMap:(NSDictionary *)classNameMap
{
    @synchronized(self) {
        _classNameMap = [classNameMap copy];
        
        [self addResponseURLsWithArray:[_classNameMap allKeys]];
    }
}

#pragma mark - Private

/**
 *  如果数组里面是URL，则自动添加到responseURLs中
 */
- (void)addResponseURLsWithArray:(NSArray *)array
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSURL *aURL = nil;
    
    for (id url in array) {
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

- (UIViewController *)nibViewControllerWithURL:(NSURL *)aURL object:(id)anObject
{
    UIViewController *newVC = nil;
    
    NSString *className = [self.classNameMap objectForKey:[aURL gq_dispatchURLString]];
    
    if (className == nil) return nil;
    
    Class cls = NSClassFromString(className);
    
    if ([cls isSubclassOfClass:[UIViewController class]]) {
        newVC = [[cls alloc] init];
    }
    
    return newVC;
}

- (UIViewController *)storyboardViewControllerWithURL:(NSURL *)aURL object:(id)anObject
{
    UIViewController *newVC = nil;
    
    if (self.storyboard) {
        @try {
            NSString *identifier = [self.storyboardIdentifierMap objectForKey:[aURL gq_dispatchURLString]];
            newVC = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        }
        @catch (NSException *exception) {
        }
    }
    
    return newVC;
}

@end
