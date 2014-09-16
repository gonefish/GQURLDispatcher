//
//  GQURLResponder.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GQURLResponder <NSObject>

- (NSURL *)responseURL;

- (void)dispatchURL:(NSURL *)aURL withObject:(id)anObject;

@optional

- (NSRegularExpression *)responseURLStringRegularExpression;

@end
