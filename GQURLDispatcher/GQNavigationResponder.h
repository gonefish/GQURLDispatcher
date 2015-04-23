//
//  GQNavigationResponder.h
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-16.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQURLResponder.h"
#import "GQSimpleResponder.h"

@interface GQNavigationResponder : GQSimpleResponder <GQURLResponder>


@end

@interface UINavigationController (GQNavigationResponder)

- (void)gq_addResponderWithAlias:(NSString *)aliasName completion:(void (^)(GQNavigationResponder *responder))completion;

- (void)gq_removeResponderWithAlias:(NSString *)aliasName;

@end