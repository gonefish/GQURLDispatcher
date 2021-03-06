//
//  GQNavigationResponderTest.m
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

- (void)testEmbedInTabBarController
{
    UIViewController *vc1 = [[UIViewController alloc] init];
    UINavigationController *nVC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    id partialMock = OCMPartialMock(nVC1);
    
    id tabBarMock = OCMClassMock([UITabBarController class]);
    OCMStub([tabBarMock selectedViewController]).andReturn(partialMock);
    
    OCMStub([partialMock tabBarController]).andReturn(tabBarMock);
    
    NSURL *testURL = GQURL(@"http://github.com/gonefish");
    
    GQNavigationResponder *responder1 = [[GQNavigationResponder alloc] initWithContainerViewController:partialMock alias:nil];
    responder1.classNameMap = @{@"http://github.com/gonefish": @"UIViewController"};
    
    XCTAssertTrue([responder1 handleURL:testURL withObject:nil], @"选中的视图控制器响应");
}

- (void)testEmbedInTabBarController2
{
    UIViewController *vc1 = [[UIViewController alloc] init];
    UINavigationController *nVC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    id partialMock = OCMPartialMock(nVC1);
    
    id tabBarMock = OCMClassMock([UITabBarController class]);
    OCMStub([tabBarMock selectedViewController]).andReturn(nil);
    
    OCMStub([partialMock tabBarController]).andReturn(tabBarMock);
    
    NSURL *testURL = GQURL(@"http://github.com/gonefish");
    
    GQNavigationResponder *responder1 = [[GQNavigationResponder alloc] initWithContainerViewController:partialMock alias:nil];
    responder1.classNameMap = @{@"http://github.com/gonefish": @"GQURLViewController"};
    
    XCTAssertFalse([responder1 handleURL:testURL withObject:nil], @"没有选择的视图控制器不应该响应");
}

- (void)testNavigationResponderCategory
{
    UIViewController *vc1 = [[UIViewController alloc] init];
    UINavigationController *nVC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    [nVC1 gq_addResponderWithAlias:@"test" completion:nil];
    
    XCTAssertTrue([[GQURLDispatcher sharedInstance] responderForAlias:@"test"], @"类别方法注册不成功");
    
    [nVC1 gq_removeResponderWithAlias:@"test"];
    
    XCTAssertFalse([[GQURLDispatcher sharedInstance] responderForAlias:@"test"], @"类别方法取消注册不成功");
}

//- (void)testHandleURLWithObject
//{
//    NSURL *url1 = GQURL(@"https://github.com/gonefish");
//    GQURLViewController *vc1 = [[GQURLViewController alloc] initWithURL:url1];
//    
//    NSURL *url2 = GQURL(@"https://github.com/gonefish/GQURLDispatcher");
//    
//    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:vc1];
//    
//    GQNavigationResponder *responder = [[GQNavigationResponder alloc] initWithContainerViewController:nVC alias:nil];
//    responder.responseURLs = @[url1, url2];
//    responder.classNameMap = @{@"https://github.com/gonefish/GQURLDispatcher" : @"GQURLViewController"};
//    
//    XCTAssertTrue([responder handleURL:url2 withObject:nil], @"");
//}

@end
