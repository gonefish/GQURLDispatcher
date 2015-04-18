//
//  UINavigationController+GQURLDispatcher.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/4/17.
//  Copyright (c) 2015年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GQNavigationResponder;

@interface UINavigationController (GQURLDispatcher)

- (void)gq_addResponderWithAlias:(NSString *)aliasName completion:(void (^)(GQNavigationResponder *responser))completion;

- (void)gq_removeResponder;

@end
