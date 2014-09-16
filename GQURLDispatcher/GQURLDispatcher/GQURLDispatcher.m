//
//  GQURLDispatcher.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQURLDispatcher.h"

@interface GQURLDispatcher ()

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSMutableArray *responders;

@end

@implementation GQURLDispatcher

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static GQURLDispatcher *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.responders = [NSMutableArray array];
    }
    
    return self;
}

- (BOOL)dispatchURL:(NSURL *)url
{
    return [self dispatchURL:url withObject:nil];
}

- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject
{
    __block BOOL rel = NO;
    
    [[self responders] enumerateObjectsWithOptions:NSEnumerationReverse
                                      usingBlock:^(id <GQURLResponder> obj, NSUInteger idx, BOOL *stop) {
//                                          if ([obj isResponseURL:url]) {
//                                              
//                                              [obj responseURL:url
//                                                    withObject:anObject];
//                                              
//                                              rel = YES;
//                                              
//                                              *stop = YES;
//                                          }
                                      }];
    
    return rel;
    
}

- (void)registerResponder:(id <GQURLResponder>)responder
{
    if ([self.responders containsObject:responder]) {
        [self unregisterResponder:responder];
    }
        
    [self.responders addObject:responder];
}

- (void)unregisterResponder:(id <GQURLResponder>)responder
{
    [self.responders removeObject:responder];
}

@end
