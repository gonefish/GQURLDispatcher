//
//  GQNavigationResponderTest.m
//  GQURLDispatcher
//
//  Created by Qian GuoQiang on 14-9-20.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GQURLViewController.h"
#import "GQNavigationResponder.h"

@interface GQNavigationResponderTest : XCTestCase

@end

@implementation GQNavigationResponderTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testClassNameMapNotFound
{
    UIViewController *vc1 = [[UIViewController alloc] init];
    UINavigationController *nVC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    NSURL *testURL = [NSURL URLWithString:@"http://github.com/gonefish"];
    
    GQNavigationResponder *responder1 = [[GQNavigationResponder alloc] initWithNavigationController:nVC1];
    
    XCTAssertFalse([responder1 handleURL:testURL withObject:nil], @"");
}

- (void)testEmbedInTabBarController
{
    UIViewController *vc1 = [[UIViewController alloc] init];
    UINavigationController *nVC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    UINavigationController *nVC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[nVC1, nVC2];
    
    NSURL *testURL = [NSURL URLWithString:@"http://github.com/gonefish"];
    
    GQNavigationResponder *responder1 = [[GQNavigationResponder alloc] initWithNavigationController:nVC1];
    responder1.classNameMap = @{@"http://github.com/gonefish": @"GQURLViewController"};
    GQNavigationResponder *responder2 = [[GQNavigationResponder alloc] initWithNavigationController:nVC2];
    responder2.classNameMap = @{@"http://github.com/gonefish": @"GQURLViewController"};
    
    XCTAssertTrue([responder1 handleURL:testURL withObject:nil], @"");
    
    XCTAssertFalse([responder2 handleURL:testURL withObject:nil], @"");
}

- (void)testHandleURLWithObject
{
    NSURL *url1 = [NSURL URLWithString:@"https://github.com/gonefish"];
    GQURLViewController *vc1 = [[GQURLViewController alloc] initWithURL:url1];
    
    NSURL *url2 = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    GQNavigationResponder *responder = [[GQNavigationResponder alloc] initWithNavigationController:nVC];
    responder.responseURLs = @[url1, url2];
    responder.classNameMap = @{@"https://github.com/gonefish/GQURLDispatcher" : @"GQURLViewController"};
    
    XCTAssertTrue([responder handleURL:url2 withObject:nil], @"");
}

@end
