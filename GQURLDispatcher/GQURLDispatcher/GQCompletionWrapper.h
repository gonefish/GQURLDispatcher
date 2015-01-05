//
//  GQCompletionWrapper.h
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/1/5.
//  Copyright (c) 2015年 Qian GuoQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GQCompletionBlock)(void);

@interface GQCompletionWrapper : NSObject

@property (readwrite, nonatomic, copy) GQCompletionBlock block;

+ (instancetype)completionBlock:(void (^)(void))completion;

@end
