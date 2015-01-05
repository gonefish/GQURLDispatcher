//
//  GQPresentResponder.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/1/5.
//  Copyright (c) 2015年 Qian GuoQiang. All rights reserved.
//

#import "GQPresentResponder.h"
#import "NSURL+GQURLUtilities.h"
#import "GQCompletionWrapper.h"

@implementation GQPresentResponder

- (BOOL)handleURL:(NSURL *)aURL withObject:(id)anObject
{
    UIViewController *newVC = [self viewControllerWithURL:aURL object:anObject];
    
    if (newVC == nil) return NO;
    
    NSString *animated = [[aURL gq_queryDictionary] objectForKey:@"animated"];
    
    GQCompletionBlock completion = nil;
    
    if ([anObject isKindOfClass:[GQCompletionWrapper class]]) {
        completion = [(GQCompletionWrapper *)anObject block];
    }
    
    [self.containerViewController presentViewController:newVC
                                               animated:animated ? [animated boolValue] : YES
                                             completion:completion];
    
    return YES;
}

@end
