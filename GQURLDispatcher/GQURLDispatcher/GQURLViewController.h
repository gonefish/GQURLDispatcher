//
//  GQURLViewController.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GQURLViewController <NSObject>

- (NSURL *)gqURL;

- (id)gqObject;

- (void)updateWithURL:(NSURL *)aURL withObject:(id)anObject;

@end

@interface GQURLViewController : UIViewController <GQURLViewController>

@property (nonatomic, strong, readonly) NSURL *gqURL;

@property (nonatomic, strong, readonly) id gqObject;

- (id)initWithURL:(NSURL *)aURL;

- (id)initWithURL:(NSURL *)aURL withObject:(id)anObject;

@end
