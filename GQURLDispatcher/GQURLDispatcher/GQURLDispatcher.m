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

- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject
{
    NSUInteger index = [[self responders] indexOfObjectWithOptions:NSEnumerationReverse
                                                       passingTest:
                        ^BOOL(id <GQURLResponder> obj, NSUInteger idx, BOOL *stop) {
                            BOOL isResponse = NO;
                            
                            if ([obj respondsToSelector:@selector(responseURLStringRegularExpression)]
                                && [obj responseURLStringRegularExpression] != nil) {
                                
                                NSString *matchString = [url dispatchURLString];
                                
                                NSRegularExpression *regex = [obj responseURLStringRegularExpression];
                                
                                NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:matchString
                                                                                     options:0
                                                                                       range:NSMakeRange(0, [matchString length])];
                                if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
                                    isResponse = YES;
                                }
                            } else {
                                for (NSURL *responseURL in [obj responseURLs]) {
                                    if ([url isSameToURL:responseURL]) {
                                        isResponse = YES;
                                        
                                        break;
                                    }
                                }
                            }
                            
                            if (isResponse) {
                                *stop = YES;
                            }
                            
                            return isResponse;
    }];
    
    if (index != NSNotFound) {
        return [self.responders[index] handleURL:url withObject:anObject];
    } else {
        return NO;
    }
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
