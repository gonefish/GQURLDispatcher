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
    return [self initWithURL:aURL object:nil];
}

- (id)initWithURL:(NSURL *)aURL object:(id)anObject
{
    self = [super init];
    
    if (self) {
        [self updateWithURL:aURL object:anObject];
        
        self.gq_urlQueryDictionary = [self.gq_url gq_queryDictionary];
    }
    
    return self;
}

- (void)updateWithURL:(NSURL *)aURL object:(id)anObject
{
    self.gq_url = aURL;
    self.gq_object = anObject;
}

@end
