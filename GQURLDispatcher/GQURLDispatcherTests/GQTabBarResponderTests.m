//
//  GQTabBarResponderTests.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GQTabBarResponder.h"
#import "GQURLViewController.h"
#import <OCMock/OCMock.h>

@interface GQTabBarResponderTests : XCTestCase

@property (nonatomic, strong) UITabBarController *testTabBarController;

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
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.testTabBarController = nil;
}

- (void)testInitWithTabBarControllerWithURL
{
    NSURL *url = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex"];
    
    GQTabBarResponder *responder = [[GQTabBarResponder alloc] initWithTabBarController:self.testTabBarController
                                                                               withURL:url];
    
    XCTAssertNil(responder.responseURLStringRegularExpression, @"");
    XCTAssertEqualObjects(responder.responseURLs, @[url], @"");
    XCTAssertEqual(self.testTabBarController, responder.tabBarController, @"");
}

- (void)testHandleURLWithObject {
    NSURL *url1 = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex?GQTabBarIndex=0"];
    NSURL *url2 = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex?GQTabBarIndex=2"];
    
    GQTabBarResponder *responder = [[GQTabBarResponder alloc] initWithTabBarController:self.testTabBarController
                                                                               withURL:[NSURL URLWithString:@"gqurl://tabBarController/selectedIndex"]];
    
    XCTAssertTrue([responder handleURL:url1 withObject:nil], @"");
    
    XCTAssertFalse([responder handleURL:url2 withObject:nil], @"");
}

@end
