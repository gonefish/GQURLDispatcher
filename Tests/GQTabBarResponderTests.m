//
//  GQTabBarResponderTests.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "GQURLDispatcher.h"
#import "GQResponers.h"

@interface GQTabBarResponderTests : XCTestCase

@property (nonatomic, strong) UITabBarController *testTabBarController;

@property (nonatomic, strong) NSURL *testTabBarURL;

@property (nonatomic, strong) GQTabBarResponder *responder;

@end

@implementation GQTabBarResponderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    UIViewController *vc2 = [[UIViewController alloc] init];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[vc1, vc2];
    
    self.testTabBarController = tabVC;
    
    self.responder = [[GQTabBarResponder alloc] initWithTabBarController:tabVC
                                                URL:GQURL(@"gqurl://tabBarController/")];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.testTabBarController = nil;
    
    self.responder = nil;
}

- (void)testHandleURLWithoutSelectedIndex
{
    NSURL *url = GQURL(@"gqurl://tabBarController/");
    
    XCTAssertFalse([self.responder handleURL:url withObject:nil], @"没有任何操作不处理");
}

- (void)testHandleURLWithoutSelectedIndexValue
{
    NSURL *url = GQURL(@"gqurl://tabBarController/?selectedIndex=");
    
    self.responder.tabBarController.selectedIndex = 1;
    XCTAssertTrue([self.responder handleURL:url withObject:nil], @"为空时使用默认值0");
    XCTAssertEqual(self.responder.tabBarController.selectedIndex, 0, @"selectedIndex的默认值为0");
}

- (void)testHandleURLWithSelectedIndex
{
    NSURL *url = GQURL(@"gqurl://tabBarController/?selectedIndex=1");
    
    XCTAssertTrue([self.responder handleURL:url withObject:nil], @"Index合法");
    XCTAssertEqual(self.responder.tabBarController.selectedIndex, 1, @"");
}

- (void)testHandleURLWithObject {
    NSURL *url = GQURL(@"gqurl://tabBarController/?selectedIndex=2");
    
    XCTAssertFalse([self.responder handleURL:url withObject:nil], @"Index超出范围，不应该处理");
    XCTAssertEqual(self.responder.tabBarController.selectedIndex, 0, @"");
}

@end
