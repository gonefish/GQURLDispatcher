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

@property (nonatomic, copy, readonly) NSString *alias;

/**
 *  URL到UIViewController类名的映射字典，键是URL，值是类名
 *  如：@{@"gq://GQURLDispatcher": @"GQURLViewController"}
 */
@property (nonatomic, copy) NSDictionary *classNameMap;

/**
 *  是否支持Storyboard
 */
@property (nonatomic) BOOL isSupportStoryboard;

/**
 *  如果不为nil，会优先尝试通过Storyboard创建实例
 */
@property (nonatomic, strong, readonly) UIStoryboard *storyboard;

/**
 *  URL到Storyboard Identifier的映射，键是URL，值是ID
 *  如：@{@"gq://GQURLDispatcher": @"MainViewController"}
*/
@property (nonatomic, copy) NSDictionary *storyboardIdentifierMap;

@property (nonatomic, weak, readonly) UIViewController *containerViewController;

- (instancetype)initWithContainerViewController:(UIViewController *)aViewController;

- (instancetype)initWithContainerViewController:(UIViewController *)aViewController alias:(NSString *)alias;

/**
 *  通过URL和自定义对象创建UIViewController的方法
 *
 *  @param aURL     URL对象
 *  @param anObject 自定义对象
 *
 *  @return 对应的UIViewController实例
 */
- (UIViewController *)viewControllerWithURL:(NSURL *)aURL object:(id)anObject;

@end
