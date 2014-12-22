//
//  GQURLViewControllerTests.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GQURLViewController.h"

@interface GQURLViewControllerTests : XCTestCase

@end

@implementation GQURLViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithURL {
    NSURL *aURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher?test=1"];
    id anObject = [[NSObject alloc] init];
    
    GQURLViewController *vc = [[GQURLViewController alloc] initWithURL:aURL withObject:anObject];
    
    XCTAssertEqual(aURL, vc.gq_url, @"");
    
    XCTAssertEqual(anObject, vc.gq_object, @"");
    
    XCTAssertEqualObjects(@{@"test": @"1"}, vc.gq_urlQueryDictionary, @"");
}

@end
