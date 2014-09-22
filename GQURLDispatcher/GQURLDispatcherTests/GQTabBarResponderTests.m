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

@end

@implementation GQTabBarResponderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithTabBarController
{
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    GQTabBarResponder *responder = [[GQTabBarResponder alloc] initWithTabBarController:tabVC];
    
    XCTAssertEqual(tabVC, responder.tabBarController, @"");
}

- (void)testHandleURLWithObject {
    NSURL *url1 = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex?GQTabBarIndex=0"];
    NSURL *url2 = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex?GQTabBarIndex=2"];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    UIViewController *vc2 = [[UIViewController alloc] init];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[vc1, vc2];
    
    GQTabBarResponder *responder = [[GQTabBarResponder alloc] initWithTabBarController:tabVC];
    
    XCTAssertTrue([responder handleURL:url1 withObject:nil], @"");
    
    XCTAssertFalse([responder handleURL:url2 withObject:nil], @"");
}

@end
