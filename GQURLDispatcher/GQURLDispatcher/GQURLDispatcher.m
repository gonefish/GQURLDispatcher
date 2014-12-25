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
    if (url == nil) return NO;
    
    if ([self.delegate respondsToSelector:@selector(urlDispatcherWillBeginDispatch:)]) {
        [self.delegate urlDispatcherWillBeginDispatch:self];
    }
    
    __block BOOL isDispatch = NO;
    
    [[self responders] enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id <GQURLResponder> responder, NSUInteger idx, BOOL *stop) {
        
        if ([self.delegate respondsToSelector:@selector(urlDispatcher:shouldWithResponder:handleURL:object:)]) {
            if ([self.delegate urlDispatcher:self
                         shouldWithResponder:responder
                                   handleURL:url
                                      object:anObject] == NO) {
                *stop = YES;
            }
        }
        
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
            if ([responder handleURL:url withObject:anObject]) {
                isDispatch = YES;
                *stop = YES;
            }
            
            if ([self.delegate respondsToSelector:@selector(urlDispatcher:didWithResponder:handleURL:object:)]) {
                [self.delegate urlDispatcher:self
                            didWithResponder:responder
                                   handleURL:url
                                      object:anObject];
            }
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(urlDispatcherDidEndDispatch:)]) {
        [self.delegate urlDispatcherDidEndDispatch:self];
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
    @synchronized(self) {
        if ([self.responders containsObject:responder]) {
            [self unregisterResponder:responder];
        }
            
        [self.responderList addObject:responder];
        
    }
}

- (void)unregisterResponder:(id <GQURLResponder>)responder
{
    @synchronized(self) {
        [self.responderList removeObject:responder];
        
    }
}


@end
