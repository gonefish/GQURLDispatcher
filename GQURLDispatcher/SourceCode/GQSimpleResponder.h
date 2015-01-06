//
//  GQSimpleResponder.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/1/4.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQSimpleResponder : NSObject

@property (nonatomic, copy) NSArray *responseURLs;

@property (nonatomic, strong) NSRegularExpression *responseURLStringRegularExpression;

@property (nonatomic, copy) NSDictionary *classNameMap;

@property (nonatomic, copy, readonly) NSString *alias;

@property (nonatomic, strong, readonly) UIViewController *containerViewController;

- (instancetype)initWithContainerViewController:(UIViewController *)aViewController alias:(NSString *)alias;

- (UIViewController *)viewControllerWithURL:(NSURL *)aURL object:(id)anObject;

@end
