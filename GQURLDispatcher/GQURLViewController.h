//
//  GQURLViewController.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GQURLViewController <NSObject>

/**
 *  更新URL和自定义对象的方法
 *
 *  @param aURL     分发的URL对象
 *  @param anObject 分发的自定义的对象
 */
- (void)updateWithURL:(NSURL *)aURL object:(id)anObject;

- (NSURL *)gq_URL;

- (id)gq_object;

@end
