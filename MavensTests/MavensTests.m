//
//  MavensTests.m
//  MavensTests
//
//  Created by Spencer Fornaciari on 3/18/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Trend.h"

@interface MavensTests : XCTestCase

@end

@implementation MavensTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testTrend
{
    Trend *trend = [Trend new];
    XCTAssertNotNil(trend, @"This trend is not nil");
//    XCTAssertNil(trend.trendName, @"This trend has a nil value by default");
}
@end
