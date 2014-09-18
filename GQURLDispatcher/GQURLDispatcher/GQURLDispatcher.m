//
//  GQURLDispatcher.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-12.
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

- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject
{
    __block BOOL rel = NO;
    
    [[self responders] enumerateObjectsWithOptions:NSEnumerationReverse
                                        usingBlock:
     ^(id <GQURLResponder> obj, NSUInteger idx, BOOL *stop) {
         if ([obj respondsToSelector:@selector(responseURLStringRegularExpression)]
             && [obj responseURLStringRegularExpression] != nil) {
         
         } else {
             for (NSURL *responseURL in [obj responseURLs]) {
                 if ([url isSameToURL:responseURL]) {
                     rel = YES;
                     
                     break;
                 }
             }
         }
         
         if (rel) {
             *stop = YES;
             
             [obj handleURL:url withObject:anObject];
         }
     }];
    
    return rel;
}

- (NSArray *)responders
{
    return [self.responderList copy];
}

- (void)registerResponder:(id <GQURLResponder>)responder
{
    if ([self.responders containsObject:responder]) {
        [self unregisterResponder:responder];
    }
        
    [self.responderList addObject:responder];
}

- (void)unregisterResponder:(id <GQURLResponder>)responder
{
    [self.responderList removeObject:responder];
}

@end
