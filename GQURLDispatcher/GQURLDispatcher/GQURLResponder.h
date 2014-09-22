//
//  GQURLResponder.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GQURLResponder <NSObject>

- (NSArray *)responseURLs;

- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject;

@optional

- (NSRegularExpression *)responseURLStringRegularExpression;

@end
