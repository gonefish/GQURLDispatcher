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

@property (nonatomic, strong) NSURL *gqURL;

@property (nonatomic, strong) id gqObject;

@property (nonatomic, strong) NSDictionary *gqURLQueryDictionary;

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
        self.gqURL = aURL;
        self.gqObject = anObject;
        self.gqURLQueryDictionary = [self.gqURL queryDictionary];
    }
    
    return self;
}

- (void)updateWithURL:(NSURL *)aURL withObject:(id)anObject
{
    // 子类实现
}

@end
