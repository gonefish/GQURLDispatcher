//
//  NSURL+GQURLUtilities.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-18.
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

@end
