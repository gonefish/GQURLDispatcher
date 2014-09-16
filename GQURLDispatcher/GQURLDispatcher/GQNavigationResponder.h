//
//  GQNavigationResponder.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQURLResponder.h"

@interface GQNavigationResponder : NSObject <GQURLResponder>

@property (nonatomic, weak, readonly) UINavigationController *navigationController;

- (id)initWithNavigationController:(UINavigationController *)aNavigationController;

@end
