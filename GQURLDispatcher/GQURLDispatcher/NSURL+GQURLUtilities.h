//
//  NSURL+GQURLUtilities.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-18.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (GQURLUtilities)

- (NSString *)dispatchURLString;

- (BOOL)isSameToURL:(NSURL *)aURL;

- (NSDictionary *)queryDictionary;

@end
