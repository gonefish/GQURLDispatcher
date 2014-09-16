//
//  GQURLDispatcher.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQURLResponder.h"

@interface GQURLDispatcher : NSObject

+ (instancetype)sharedInstance;

- (BOOL)dispatchURL:(NSURL *)url;

- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject;

- (void)registerResponder:(id <GQURLResponder>)responder;

- (void)unregisterResponder:(id <GQURLResponder>)responder;

@end
