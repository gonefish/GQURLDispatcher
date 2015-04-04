//
//  GQSimpleResponderTests.m
//  GQURLDispatcher
//
//  Created by 钱国强 on 15/1/5.
//  Copyright (c) 2015年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GQSimpleResponder.h"
#import "GQURLDispatcher.h"
#import <OCMock/OCMock.h>

@interface GQSimpleResponderTests : XCTestCase

@property (nonatomic, strong) GQSimpleResponder *testSimpleResponder;

@end

@implementation GQSimpleResponderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.testSimpleResponder = [GQSimpleResponder new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.testSimpleResponder = nil;
}

- (void)testViewControllerWithURLObjectReturnNil {
    NSURL *testURL = GQURL(@"http://github.com/gonefish");
    
    XCTAssertNil([self.testSimpleResponder viewControllerWithURL:testURL object:nil], @"不存在的URL返回nil");
}

- (void)testViewControllerWithURLObjectReturnErrorClass {
    NSString *testURLString = @"http://github.com/gonefish";
    self.testSimpleResponder.classNameMap = @{testURLString: @"NSObject"};
    
    XCTAssertNil([self.testSimpleResponder viewControllerWithURL:GQURL(testURLString) object:nil], @"不是UIViewController的子类时返回nil");
}

- (void)testViewControllerWithURLObjectReturnUIViewController {
    NSString *testURLString = @"http://github.com/gonefish";
    self.testSimpleResponder.classNameMap = @{testURLString: @"UIViewController"};
    
    XCTAssert([self.testSimpleResponder viewControllerWithURL:GQURL(testURLString) object:nil], @"应该返回UIViewController实例");
}

- (void)testViewControllerWithURLObjectReturnInstance
{
    NSString *testURLString = @"http://github.com/gonefish";
    UIViewController *testVC = [UIViewController new];
    self.testSimpleResponder.classNameMap = @{testURLString: testVC};
    
    XCTAssertEqualObjects(testVC, [self.testSimpleResponder viewControllerWithURL:GQURL(testURLString) object:nil], @"应该返回设置的实例变量");
    
}

- (void)testSetClassNameMap
{
    NSString *testURLString = @"http://github.com/gonefish";
    self.testSimpleResponder.classNameMap = @{testURLString: @"UIViewController"};
    
    XCTAssert([self.testSimpleResponder.responseURLs count] == 1, @"URL字符串的key没有添加到responseURLs中");
}

@end
