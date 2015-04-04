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

/**
 *  通过Xib创建UIViewController实例
 *
 */
- (UIViewController *)nibViewControllerWithURL:(NSURL *)aURL object:(id)anObject
{
    UIViewController *newVC = nil;
    
    id classNameOrInstance = [self.classNameMap objectForKey:[aURL gq_dispatchURLString]];
    
    if (classNameOrInstance == nil) return nil;
    
    if ([classNameOrInstance isKindOfClass:[UIViewController class]]) {
        return classNameOrInstance;
    } else {
        NSAssert([classNameOrInstance isKindOfClass:[NSString class]], @"不是实例就是字符串");
        
        Class cls = NSClassFromString(classNameOrInstance);
        
        if (cls
            && [cls isSubclassOfClass:[UIViewController class]]) {
            newVC = [[cls alloc] init];
        }
        
        return newVC;
    }
}

/**
 *  使用Storyboard创建UIViewController实例
 *
 */
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
