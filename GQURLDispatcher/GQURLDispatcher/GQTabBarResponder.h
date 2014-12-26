//
//  GQTabBarResponder.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQURLResponder.h"

@interface GQTabBarResponder : NSObject <GQURLResponder>

@property (nonatomic, strong, readonly) UITabBarController *tabBarController;

@property (nonatomic, copy, readonly) NSArray *responseURLs;

- (id)initWithTabBarController:(UITabBarController *)aTabBarController URL:(NSURL *)aURL;

@end
