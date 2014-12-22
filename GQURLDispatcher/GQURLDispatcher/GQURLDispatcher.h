//
//  GQURLDispatcher.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQURLResponder.h"

@protocol GQURLDispatcherDelegate;

@interface GQURLDispatcher : NSObject

@property (nonatomic, weak) id<GQURLDispatcherDelegate> delegate;

+ (instancetype)sharedInstance;

- (BOOL)dispatchURL:(NSURL *)url;

- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject;

- (NSArray *)responders;

- (void)registerResponder:(id <GQURLResponder>)responder;

- (void)unregisterResponder:(id <GQURLResponder>)responder;

@end

@protocol GQURLDispatcherDelegate <NSObject>

@optional

- (BOOL)urlDispatcher:(GQURLDispatcher *)urlDispatcher shouldWithResponder:(id <GQURLResponder>)responder handleURL:(NSURL *)aURL object:(id)anObject;

- (void)urlDispatcher:(GQURLDispatcher *)urlDispatcher didWithResponder:(id <GQURLResponder>)responder handleURL:(NSURL *)aURL object:(id)anObject;

@end