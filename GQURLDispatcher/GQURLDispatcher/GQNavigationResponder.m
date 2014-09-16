//
//  GQNavigationResponder.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQNavigationResponder.h"

@interface GQNavigationResponder ()

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation GQNavigationResponder

- (id)initWithNavigationController:(UINavigationController *)aNavigationController
{
    self = [super init];
    
    if (self) {
        self.navigationController = aNavigationController;
    }
    
    return self;
}

@end
