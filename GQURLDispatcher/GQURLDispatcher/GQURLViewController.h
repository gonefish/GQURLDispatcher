//
//  GQURLViewController.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQURLViewController : UIViewController

/** 模块化页面的初始化方法
 
 @param pageID 界面唯一ID
 */
- (id)initWithPageID:(NSString *)pageID;

/** 带参数的模块化页面初始化方法
 
 @param pageID 界面唯一ID
 @param anObject 自定义参数
 */
- (id)initWithPageID:(NSString *)pageID withObject:(id)anObject;


/** 更新当前页
 
 @return YES将不会过滤到下一页
 */
- (BOOL)updateWithPageArgs:(NSDictionary *)args;


@end
