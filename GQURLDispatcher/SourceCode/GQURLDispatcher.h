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

/**
 *  调用dispatchURL:withObject:，withObject传递nil
 *
 */
- (BOOL)dispatchURL:(NSURL *)url;

+ (BOOL)dispatchURL:(NSURL *)url;

/**
 *  核心方法，调用时会依次将URL和自定义对象传递给匹配的Responder响应
 *
 *  @param url      URL对象
 *  @param anObject 自定义的参数
 *
 *  @return 如果有相应的响应者处理则返回YES，否则为NO
 */
- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject;

+ (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject;

/**
 *  返回所有的响应者
 *
 *  @return 响应者数组
 */
- (NSArray *)responders;

/**
 *  注册响应者实例
 *
 *  @param responder 实现GQURLResponder的实例
 */
- (void)registerResponder:(id <GQURLResponder>)responder;

/**
 *  取消注册响应者实例
 *
 *  @param responder 实现GQURLResponder的实例
 */
- (void)unregisterResponder:(id <GQURLResponder>)responder;

/**
 *  通过别名获取响应者
 *
 */
- (id <GQURLResponder>)responderForAlias:(NSString *)alias;

@end

@protocol GQURLDispatcherDelegate <NSObject>

@optional

/**
 *  开始URL分发循环
 *
 */
- (void)URLDispatcherWillBeginDispatch:(GQURLDispatcher *)URLDispatcher;

/**
 *  结束URL分发循环
 *
 */
- (void)URLDispatcherDidEndDispatch:(GQURLDispatcher *)URLDispatcher;

/**
 *  是否使用该响应者处理URL
 *
 *  @return 如果返回NO，则该响应者不处理URL
 */
- (BOOL)URLDispatcher:(GQURLDispatcher *)URLDispatcher shouldWithResponder:(id <GQURLResponder>)responder handleURL:(NSURL *)aURL object:(id)anObject;

/**
 *  使用响应者处理完毕
 *
 */
- (void)URLDispatcher:(GQURLDispatcher *)URLDispatcher didWithResponder:(id <GQURLResponder>)responder handleURL:(NSURL *)aURL object:(id)anObject;


@end