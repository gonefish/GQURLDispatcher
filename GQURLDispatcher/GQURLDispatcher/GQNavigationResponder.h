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

@property (nonatomic, strong, readonly) UINavigationController *navigationController;

@property (nonatomic, copy) NSArray *responseURLs;

@property (nonatomic, strong) NSRegularExpression *responseURLStringRegularExpression;

@property (nonatomic, copy) NSDictionary *classNameMap;

@property (nonatomic, copy, readonly) NSString *alias;

- (id)initWithNavigationController:(UINavigationController *)aNavigationController alias:(NSString *)alias;

@end
