//
//  GQURLDispatcher.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GQURLResponder.h"

#define GQURL(s) [NSURL URLWithString:s] 

@protocol GQURLDispatcherDelegate, GQURLResponder;

@interface GQURLDispatcher : NSObject

@property (nonatomic, weak) id<GQURLDispatcherDelegate> delegate;

/**
 *  返回单例
 *
 */
+ (instancetype)sharedInstance;

/**
 *  核心方法，等于dispatchURL:withObject:中，withObject为nil
 *
 */
- (BOOL)dispatchURL:(NSURL *)url;

/**
 *  快捷方法，使用单例调用dispatchURL
 *
 */
+ (BOOL)dispatchURL:(NSURL *)url;

/**
 *  核心方法，将要分发的URL和自定义对象依次传递给匹配的Responder进行处理
 *  流程图 https://raw.githubusercontent.com/gonefish/GQURLDispatcher/master/Dispatch%20Flow.png
 *
 *  @param url      URL对象
 *  @param anObject 自定义的对象
 *
 *  @return 如果有相应的响应者处理则返回YES，否则为NO
 */
- (BOOL)dispatchURL:(NSURL *)url withObject:(id)anObject;

/**
 *  快捷方法，使用单例调用dispatchURL:withObject:
 *
 */
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
 *  @return 返回该别名的Responder，否则为nil
 */
- (id <GQURLResponder>)responderForAlias:(NSString *)alias;

@end

@protocol GQURLDispatcherDelegate <NSObject>

@optional

/**
 *  是否要开始分发请求
 *
 *  @return 如果返回NO，将不会处理这次请求
 */
- (BOOL)URLDispatcherShouldBeginDispatch:(GQURLDispatcher *)URLDispatcher handleURL:(NSURL *)aURL object:(id)anObject;

/**
 *  URL分发请求结束
 *
 */
- (void)URLDispatcherDidEndDispatch:(GQURLDispatcher *)URLDispatcher;


@end