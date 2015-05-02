//
//  GQURLDispatcher.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQURLDispatcher.h"
#import "NSURL+GQURLUtilities.h"

@interface GQURLDispatcher ()

@property (nonatomic, strong) NSMutableArray *responderList;
@property (nonatomic, strong) NSMutableDictionary *responderAliases;

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
        self.responderList = [NSMutableArray array];
        self.responderAliases = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (BOOL)dispatchURL:(NSURL *)url
{
    return [self dispatchURL:url withObject:nil];
}

+ (BOOL)dispatchURL:(NSURL *)url
{
    return [[self sharedInstance] dispatchURL:url];
}


- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject
{
    NSAssert([NSThread isMainThread], @"只允许在主线程使用");
    
    if (url == nil) return NO;
    
    if ([self.delegate respondsToSelector:@selector(URLDispatcherShouldBeginDispatch:handleURL:object:)]) {
        if ([self.delegate URLDispatcherShouldBeginDispatch:self handleURL:url object:anObject] == NO) {
            return NO;
        }
    }
    
    [self cleanResponer];
    
    // 开始匹配Responder
    __block BOOL isDispatch = NO;
    
    [self.responderList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id <GQURLResponder> responder, NSUInteger idx, BOOL *stop) {
        
        // 是否需要响应
        BOOL isResponse = NO;

        if ([responder respondsToSelector:@selector(responseURLStringRegularExpression)]
            && [responder responseURLStringRegularExpression] != nil) {
            
            NSString *matchString = [url gq_dispatchURLString];
            
            NSRegularExpression *regex = [responder responseURLStringRegularExpression];
            
            NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:matchString
                                                                 options:0
                                                                   range:NSMakeRange(0, [matchString length])];
            if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
                isResponse = YES;
            }
        } else {
            for (NSURL *responseURL in [responder responseURLs]) {
                if ([url gq_isSameToURL:responseURL]) {
                    isResponse = YES;
                    
                    break;
                }
            }
        }
        
        if (isResponse) {
            // 如果responder返回NO，则继续分发
            if ([responder handleURL:url withObject:anObject]) {
                isDispatch = YES;
                *stop = YES;
            }
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(URLDispatcherDidEndDispatch:)]) {
        [self.delegate URLDispatcherDidEndDispatch:self];
    }
    
    return isDispatch;
}

+ (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject
{
    return [[self sharedInstance] dispatchURL:url withObject:anObject];
}

- (NSArray *)responders
{
    return [self.responderList copy];
}

- (void)registerResponder:(id <GQURLResponder>)responder
{
    if (![responder conformsToProtocol:@protocol(GQURLResponder)]) return;
    
    @synchronized(self) {
        if ([self.responders containsObject:responder]) {
            [self unregisterResponder:responder];
        }
            
        [self.responderList addObject:responder];
        
        if ([responder respondsToSelector:@selector(alias)]
            && [responder alias] != nil) {
            [self.responderAliases setObject:responder
                              forKey:[responder alias]];
        }
    }
}

- (void)unregisterResponder:(id <GQURLResponder>)responder
{
    if (![responder conformsToProtocol:@protocol(GQURLResponder)]) return;
    
    @synchronized(self) {
        [self.responderList removeObject:responder];
        
        if ([responder respondsToSelector:@selector(alias)]
            && [responder alias] != nil) {
            [self.responderAliases removeObjectForKey:[responder alias]];
        }
    }
}

- (id <GQURLResponder>)responderForAlias:(NSString *)alias
{
    return [self.responderAliases objectForKey:alias];
}

#pragma mark - Private


- (void)cleanResponer
{
    // 尝试清理Responder
    
    NSMutableArray *needRemoveResponers = [NSMutableArray array];
    
    [self.responderList enumerateObjectsUsingBlock:^(id <GQURLResponder> responder, NSUInteger idx, BOOL *stop) {
        if ([responder respondsToSelector:@selector(needRemove)]) {
            
            if ([responder needRemove]) {
                [needRemoveResponers addObject:responder];
            }
        }
    }];
    
    [needRemoveResponers enumerateObjectsUsingBlock:^(id <GQURLResponder> responder, NSUInteger idx, BOOL *stop) {
        [[GQURLDispatcher sharedInstance] unregisterResponder:responder];
    }];
}

@end
