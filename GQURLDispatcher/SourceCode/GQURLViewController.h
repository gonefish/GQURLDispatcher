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

- (void)updateWithURL:(NSURL *)aURL object:(id)anObject;

@end

@interface GQURLViewController : UIViewController <GQURLViewController>

@property (nonatomic, strong, readonly) NSURL *gq_url;

@property (nonatomic, strong, readonly) id gq_object;

@property (nonatomic, strong, readonly) NSDictionary *gq_urlQueryDictionary;

- (id)initWithURL:(NSURL *)aURL;

- (id)initWithURL:(NSURL *)aURL object:(id)anObject;

@end
