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
    NSURL *url1 = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    GQURLViewController *vc1 = [[GQURLViewController alloc] initWithURL:url1];
    
    NSURL *url2 = [NSURL URLWithString:@"https://github.com/gonefish/GQFlowController"];
    GQURLViewController *vc2 = [[GQURLViewController alloc] initWithURL:url2];
    id vc2Mock = OCMPartialMock(vc2);
    
    NSURL *url3 = [NSURL URLWithString:@"https://github.com/gonefish"];
    GQURLViewController *vc3 = [[GQURLViewController alloc] initWithURL:url3];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[vc1, vc2Mock, vc3];
    
    GQTabBarResponder *responder = [[GQTabBarResponder alloc] initWithTabBarController:tabVC];
    responder.responseURLs = @[url1, url2, url3];
    
    [responder handleURL:url2 withObject:nil];
    
    XCTAssertEqual(vc2Mock, responder.tabBarController.selectedViewController, @"");
    
    OCMVerify([vc2Mock updateWithURL:url2 withObject:nil]);
}

@end
