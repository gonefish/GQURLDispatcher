//
//  GQApplicationURLResponder.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14/12/19.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQApplicationURLResponder.h"

@implementation GQApplicationURLResponder

- (id)init
{
    self = [super init];
    
    if (self) {
        _responseURLStringRegularExpression = [NSRegularExpression regularExpressionWithPattern:@".*"
                                                                                        options:NSRegularExpressionCaseInsensitive
                                                    error:nil];
    }
    
    return self;
}

- (NSArray *)responseURLs
{
    return nil;
}

- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    if ([[UIApplication sharedApplication] canOpenURL:aURL]) {
        return [[UIApplication sharedApplication] openURL:aURL];
    } else {
        return NO;
    }
}

@end
