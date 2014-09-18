//
//  GQURLDispatcherTests.m
//  GQURLDispatcherTests
//
//  Created by 钱国强 on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GQURLDispatcher.h"
#import "GQURLResponder.h"
#import <OCMock/OCMock.h>

@interface GQURLDispatcherTests : XCTestCase

@property (nonatomic, strong) GQURLDispatcher *testURLDispatcher;
@end

@implementation GQURLDispatcherTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.testURLDispatcher = [[GQURLDispatcher alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.testURLDispatcher = nil;
}

- (void)testSharedInstance
{
    XCTAssertEqual([GQURLDispatcher sharedInstance], [GQURLDispatcher sharedInstance], @"");
}

- (void)testRegisterResponder
{
    XCTAssertEqual(0, [[self.testURLDispatcher responders] count], @"");
    
    id responder1 = OCMProtocolMock(@protocol(GQURLResponder));
    
    [self.testURLDispatcher registerResponder:responder1];
    
    XCTAssertEqual(1, [[self.testURLDispatcher responders] count], @"");
    
    [self.testURLDispatcher registerResponder:responder1];
    
    XCTAssertEqual(1, [[self.testURLDispatcher responders] count], @"");
    
    id responder2 = OCMProtocolMock(@protocol(GQURLResponder));
    
    [self.testURLDispatcher registerResponder:responder2];
    
    XCTAssertEqual(2, [[self.testURLDispatcher responders] count], @"");
}

- (void)testUnregisterResponder
{
    id responder1 = OCMProtocolMock(@protocol(GQURLResponder));
    
    id responder2 = OCMProtocolMock(@protocol(GQURLResponder));
    
    [self.testURLDispatcher registerResponder:responder1];
    
    [self.testURLDispatcher unregisterResponder:responder2];
    
    XCTAssertEqual(1, [[self.testURLDispatcher responders] count], @"");
    
    [self.testURLDispatcher unregisterResponder:responder1];
    
    XCTAssertEqual(0, [[self.testURLDispatcher responders] count], @"");
}

- (void)testDispatchURL
{
    id mockGQURLDispatcher = OCMClassMock([GQURLDispatcher class]);
}

@end
