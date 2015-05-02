//
//  GQURLResponder.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GQURLResponder <NSObject>

/**
 *  需要响应的URL地址
 *
 *  @return 包含NSURL的数组
 */
- (NSArray *)responseURLs;

/**
 *  处理方法
 *
 *  @param aURL     分发的URL
 *  @param anObject 额外的对象
 *
 *  @return 是否成功的处理URL
 */
- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject;

@optional

/**
 *  通过正则表达式匹配，来确认需要响应的URL
 *
 * @return 正则表达式对象
 */
- (NSRegularExpression *)responseURLStringRegularExpression;

/**
 *  Responder的别名，用于快速查找
 *
 *  @return 别名字符串
 */
- (NSString *)alias;

/**
 *  Responder可以声明自己需要被删除
 *
 *  @return 如果返回YES，在下次分发URL时会被移除
 */
- (BOOL)needRemove;

@end
