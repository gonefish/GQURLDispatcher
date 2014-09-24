//
//  NSURL+GQURLUtilities.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-18.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "NSURL+GQURLUtilities.h"

@implementation NSURL (GQURLUtilities)

- (NSString *)dispatchURLString
{
    return [[[self absoluteString] componentsSeparatedByString:@"?"] objectAtIndex:0];
}

- (BOOL)isSameToURL:(NSURL *)aURL
{
    return [[self dispatchURLString] isEqualToString:[aURL dispatchURLString]];
}

- (NSDictionary *)queryDictionary {
    if (self.query == nil) return nil;
    
    __block NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [[self.query componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        
        NSRange queryRange = [obj rangeOfString:@"="];
        
        if (queryRange.location == NSNotFound) {
            return;
        }
        
        NSString *key = [obj substringToIndex:queryRange.location];
        NSString *value = [obj substringFromIndex:queryRange.location + 1];
        
        if (key != nil) {
            [dictionary setObject:[value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                           forKey:[key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    }];
    
    return [dictionary copy];
}

@end
