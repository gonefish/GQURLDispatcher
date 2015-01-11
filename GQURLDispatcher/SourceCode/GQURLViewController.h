//
//  GQURLViewController.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GQURLViewController <NSObject>

- (NSURL *)gq_url;

- (id)gq_object;


/**
 *  更新URL和自定义对象的方法
 *
 *  @param aURL     分发的URL对象
 *  @param anObject 分发的自定义的对象
 */
- (void)updateWithURL:(NSURL *)aURL object:(id)anObject;

@end

@interface GQURLViewController : UIViewController <GQURLViewController>

@property (nonatomic, strong, readonly) NSURL *gq_url;

@property (nonatomic, strong, readonly) id gq_object;

@property (nonatomic, strong, readonly) NSDictionary *gq_urlQueryDictionary;

- (id)initWithURL:(NSURL *)aURL;

- (id)initWithURL:(NSURL *)aURL object:(id)anObject;

@end
