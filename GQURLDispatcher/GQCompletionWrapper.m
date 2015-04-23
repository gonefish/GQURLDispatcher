//
//  GQCompletionWrapper.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/1/5.
//  Copyright (c) 2015年 Qian GuoQiang. All rights reserved.
//

#import "GQCompletionWrapper.h"

@implementation GQCompletionWrapper

+ (instancetype)completionBlock:(void (^)(void))completion
{
    GQCompletionWrapper *instance = [[self alloc] init];
    instance.block = completion;
    
    return instance;
}

@end
