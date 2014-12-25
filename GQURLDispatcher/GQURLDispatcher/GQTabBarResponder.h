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

@property (nonatomic, weak) UITabBarController *tabBarController;

@property (nonatomic, copy, readonly) NSArray *responseURLs;

@property (nonatomic, strong, readonly) NSRegularExpression *responseURLStringRegularExpression;

- (id)initWithTabBarController:(UITabBarController *)aTabBarController withURL:(NSURL *)aURL;

@end
