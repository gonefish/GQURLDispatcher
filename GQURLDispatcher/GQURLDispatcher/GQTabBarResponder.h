//
//  GQTabBarResponder.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQURLResponder.h"

@interface GQTabBarResponder : NSObject <GQURLResponder>

@property (nonatomic, weak) UITabBarController *tabBarController;

@property (nonatomic, strong) NSArray *responseURLs;

@property (nonatomic, strong) NSRegularExpression *responseURLStringRegularExpression;

- (id)initWithTabBarController:(UITabBarController *)aTabBarController;

@end
