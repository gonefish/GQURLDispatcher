//
//  GQURLDispatcherTests.m
//  GQURLDispatcherTests
//
//  Created by Qian GuoQiang on 14-9-12.
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
    XCTAssertEqual([GQURLDispatcher sharedInstance], [GQURLDispatcher sharedInstance], @"单例实现不正确");
}

- (void)testRegisterResponder
{
    id responder1 = OCMProtocolMock(@protocol(GQURLResponder));
    
    [self.testURLDispatcher registerResponder:responder1];
    
    id noResponder = [[NSObject alloc] init];
    
    [self.testURLDispatcher registerResponder:noResponder];
    
    XCTAssertEqual(1, [[self.testURLDispatcher responders] count], @"没有实现GQURLResonder协议的对象忽略");
    
    [self.testURLDispatcher registerResponder:responder1];
    
    XCTAssertEqual(1, [[self.testURLDispatcher responders] count], @"已经存在的对象不在进行添加");
    
    id responder2 = OCMProtocolMock(@protocol(GQURLResponder));
    
    [self.testURLDispatcher registerResponder:responder2];
    
    XCTAssertEqualObjects([[self.testURLDispatcher responders] lastObject], responder2, @"后注册的在响应链的后面");
    
    [self.testURLDispatcher registerResponder:responder1];
    
    XCTAssertEqualObjects([[self.testURLDispatcher responders] lastObject], responder1, @"注册已经存在对象时，将该对象移到最后");
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

- (void)testResponderForAlias
{
    id responder = OCMProtocolMock(@protocol(GQURLResponder));
    
    NSString *aliasName = @"GQ";
    
    OCMStub([responder alias]).andReturn(aliasName);
    
    [self.testURLDispatcher registerResponder:responder];
    
    XCTAssertEqualObjects(responder, [self.testURLDispatcher responderForAlias:aliasName], @"通过别名查询失败");
    XCTAssertNil([self.testURLDispatcher responderForAlias:@"URL"], @"不应该返回不存在别名的responder");
    
    [self.testURLDispatcher unregisterResponder:responder];
    
    XCTAssertNil([self.testURLDispatcher responderForAlias:aliasName], @"已经取消注册的responder不能通过别名找到");
}

- (void)testDispatchURLPass
{
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    
    id responder = OCMProtocolMock(@protocol(GQURLResponder));
    
    NSArray *rel = @[testURL];
    
    OCMStub([responder responseURLs]).andReturn(rel);
    
    [self.testURLDispatcher registerResponder:responder];
    
    OCMStub([responder handleURL:testURL withObject:nil]).andReturn(YES);
    
    XCTAssertTrue([self.testURLDispatcher dispatchURL:testURL], @"URL应该匹配");
    
    OCMVerify([responder responseURLs]);
}

- (void)testDispatchURLFail
{
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    
    id responder = OCMProtocolMock(@protocol(GQURLResponder));
    
    NSArray *rel = @[[NSURL URLWithString:@"https://github.com/gonefish"]];
    
    OCMStub([responder responseURLs]).andReturn(rel);
    
    [self.testURLDispatcher registerResponder:responder];
    
    XCTAssertFalse([self.testURLDispatcher dispatchURL:testURL], @"URL应该匹配失败");
}

- (void)testResponseURLStringRegularExpressionPass
{
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    
    id responder = OCMProtocolMock(@protocol(GQURLResponder));
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"https://github.com/gonefish/.*"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    OCMStub([responder responseURLStringRegularExpression]).andReturn(regex);
    
    [self.testURLDispatcher registerResponder:responder];
    
    OCMStub([responder handleURL:testURL withObject:nil]).andReturn(YES);
    
    XCTAssertTrue([self.testURLDispatcher dispatchURL:testURL], @"正则表达式应该匹配");
}

- (void)testResponseURLStringRegularExpressionFail
{
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    
    id responder = OCMProtocolMock(@protocol(GQURLResponder));
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@""
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    OCMStub([responder responseURLStringRegularExpression]).andReturn(regex);
    
    [self.testURLDispatcher registerResponder:responder];
    
    XCTAssertFalse([self.testURLDispatcher dispatchURL:testURL], @"正则表达式应该匹配失败");
}

- (void)testGQURLDispatcherDelegate
{
    id <GQURLDispatcherDelegate> delegateMock = OCMProtocolMock(@protocol(GQURLDispatcherDelegate));
    
    self.testURLDispatcher.delegate = delegateMock;
    
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    
    id responder = [self mockURLResponderWithURL:testURL];
    
    OCMStub([delegateMock URLDispatcher:self.testURLDispatcher shouldWithResponder:responder handleURL:testURL object:nil]).andReturn(YES);
    
    [self.testURLDispatcher registerResponder:responder];
    
    [self.testURLDispatcher dispatchURL:testURL];
    
    OCMVerify([delegateMock URLDispatcherWillBeginDispatch:self.testURLDispatcher]);
    
    OCMVerify([delegateMock URLDispatcher:self.testURLDispatcher shouldWithResponder:responder handleURL:testURL object:nil]);
    
    OCMVerify([delegateMock URLDispatcher:self.testURLDispatcher didWithResponder:responder handleURL:testURL object:nil]);
    
    OCMVerify([delegateMock URLDispatcherDidEndDispatch:self.testURLDispatcher]);
}

- (void)testURLDispatcherShouldWithResponderHandleURLObject
{
    NSURL *testURL = [NSURL URLWithString:@"https://github.com/gonefish/GQURLDispatcher"];
    
    id responder = [self mockURLResponderWithURL:testURL];
    
    id <GQURLDispatcherDelegate> delegateMock = OCMProtocolMock(@protocol(GQURLDispatcherDelegate));
    
    OCMStub([delegateMock URLDispatcher:self.testURLDispatcher shouldWithResponder:responder handleURL:testURL object:nil]).andReturn(NO);
    
    self.testURLDispatcher.delegate = delegateMock;
    
    [self.testURLDispatcher registerResponder:responder];
    
    XCTAssertFalse([self.testURLDispatcher dispatchURL:testURL], @"不应该响应responder");
}

- (id <GQURLResponder>)mockURLResponderWithURL:(NSURL *)aURL
{
    id responder = OCMProtocolMock(@protocol(GQURLResponder));
    
    NSArray *rel = @[aURL];
    
    OCMStub([responder responseURLs]).andReturn(rel);
    
    return responder;
}

@end
