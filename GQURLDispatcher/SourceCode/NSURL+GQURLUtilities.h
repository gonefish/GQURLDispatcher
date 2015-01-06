//
//  NSURL+GQURLUtilities.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-18.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (GQURLUtilities)

- (NSString *)gq_dispatchURLString;

- (BOOL)gq_isSameToURL:(NSURL *)aURL;

- (NSDictionary *)gq_queryDictionary;

@end
