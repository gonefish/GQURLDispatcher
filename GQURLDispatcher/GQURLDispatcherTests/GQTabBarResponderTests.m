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

@property (nonatomic, strong) NSURL *testTabBarURL;

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
    
    self.testTabBarURL = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.testTabBarController = nil;
    
    self.testTabBarURL = nil;
}

- (void)testHandleURLWithObject {
    NSURL *url1 = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex"];
    NSURL *url2 = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex?GQTabBarIndex=1"];
    NSURL *url3 = [NSURL URLWithString:@"gqurl://tabBarController/selectedIndex?GQTabBarIndex=2"];
    
    GQTabBarResponder *responder = [[GQTabBarResponder alloc] initWithTabBarController:self.testTabBarController
                                                                               withURL:self.testTabBarURL];
    
    XCTAssertTrue([responder handleURL:url1 withObject:nil], @"Index合法");
    
    XCTAssertTrue([responder handleURL:url2 withObject:nil], @"Index合法");
    
    XCTAssertFalse([responder handleURL:url3 withObject:nil], @"Index超出范围，不应该咱就");
}

@end
