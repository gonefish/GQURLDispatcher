//
//  GQURLUtilities.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-18.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSURL+GQURLUtilities.h"

@interface GQURLUtilitiesTests : XCTestCase

@end

@implementation GQURLUtilitiesTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDispatchURLString
{
    NSString *dispatchURLString = @"https://github.com/gonefish/GQURLDispatcher";
    
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher?test=1"];
    
    XCTAssertEqualObjects(dispatchURLString, [testURL dispatchURLString], @"");
}

- (void)testIsSameToURL
{
    NSURL *testURLa = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    NSURL *testURLb = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher?test=1"];
    
    XCTAssertTrue([testURLa isSameToURL:testURLb], @"");
}

- (void)testQueryDictionary
{
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher?lang=%e4%b8%ad%e6%96%87&test=1"];
    
    NSDictionary *testDictionary = [testURL queryDictionary];
    
    XCTAssertEqualObjects(testDictionary[@"lang"], @"中文", @"");
    XCTAssertEqualObjects(testDictionary[@"test"], @"1", @"");
}

@end
