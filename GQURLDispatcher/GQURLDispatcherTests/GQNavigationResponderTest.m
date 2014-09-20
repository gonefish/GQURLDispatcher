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

- (void)testInitWithNavigationController {
    UIViewController *vc = [[UIViewController alloc] init];
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    GQNavigationResponder *responder = [[GQNavigationResponder alloc] initWithNavigationController:nVC];
    
    XCTAssertEqual(nVC, responder.navigationController, @"");
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
    
    [responder handleURL:url2 withObject:nil];
    
    XCTAssertEqualObjects(url2, [(GQURLViewController *)[nVC topViewController] gqURL], @"");
}

@end
