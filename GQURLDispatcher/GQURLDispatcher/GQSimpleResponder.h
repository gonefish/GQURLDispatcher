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

@property (nonatomic, copy) NSDictionary *classNameMap;

- (UIViewController *)viewControllerWithURL:(NSURL *)aURL withObject:(id)anObject;

@end
