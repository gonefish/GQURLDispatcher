//
//  GQURLViewController.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQURLViewController.h"
#import "NSURL+GQURLUtilities.h"

@interface GQURLViewController ()

@property (nonatomic, strong) NSURL *gq_url;

@property (nonatomic, strong) id gq_object;

@property (nonatomic, strong) NSDictionary *gq_urlQueryDictionary;

@end

@implementation GQURLViewController

- (id)initWithURL:(NSURL *)aURL
{
    return [self initWithURL:aURL withObject:nil];
}

- (id)initWithURL:(NSURL *)aURL withObject:(id)anObject
{
    self = [super init];
    
    if (self) {
        self.gq_url = aURL;
        self.gq_object = anObject;
        self.gq_urlQueryDictionary = [self.gq_url gq_queryDictionary];
    }
    
    return self;
}

- (void)updateWithURL:(NSURL *)aURL withObject:(id)anObject
{
    // 子类实现
}

@end
