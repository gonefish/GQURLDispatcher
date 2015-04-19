//
//  UINavigationController+GQURLDispatcher.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/4/17.
//  Copyright (c) 2015年 Qian GuoQiang. All rights reserved.
//

#import "UINavigationController+GQURLDispatcher.h"
#import "GQURLDispatcher.h"

@implementation UINavigationController (GQURLDispatcher)

- (void)gq_addResponderWithAlias:(NSString *)aliasName completion:(void (^)(GQNavigationResponder *responder))completion
{
    GQNavigationResponder *responer =
    [[GQNavigationResponder alloc] initWithContainerViewController:self
                                                             alias:aliasName];
    
    if (completion) {
        completion(responer);
    }
    
    [[GQURLDispatcher sharedInstance] registerResponder:responer];
}

- (void)gq_removeResponderWithAlias:(NSString *)aliasName;
{
    id <GQURLResponder> responder = [[GQURLDispatcher sharedInstance] responderForAlias:aliasName];
    
    if (responder) {
        [[GQURLDispatcher sharedInstance] unregisterResponder:responder];
    }
    
}

@end
