//
//  GQNavigationResponder.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQURLResponder.h"

@interface GQNavigationResponder : NSObject <GQURLResponder>

@property (nonatomic, weak) UINavigationController *navigationController;

@property (nonatomic, copy) NSArray *responseURLs;

@property (nonatomic, copy) NSRegularExpression *responseURLStringRegularExpression;

@property (nonatomic, copy) NSDictionary *classNameMap;

- (id)initWithNavigationController:(UINavigationController *)aNavigationController;

@end
