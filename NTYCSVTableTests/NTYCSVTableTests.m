//
//  NTYCSVTableTests.m
//  NTYCSVTableTests
//
//  Created by Naoto Kaneko on 2014/04/15.
//  Copyright (c) 2014 Naoto Kaneko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NTYCSVTable.h"

@interface NTYCSVTableTests : XCTestCase
@property (nonatomic) NTYCSVTable *table;
@end

@implementation NTYCSVTableTests

- (void)setUp
{
    [super setUp];
    
    NSURL *csvURL = [[NSBundle bundleForClass:self.class] URLForResource:@"sample" withExtension:@"csv"];
    self.table = [[NTYCSVTable alloc] initWithContentsOfURL:csvURL];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testHeaders
{
    NSArray *expect = @[@"id", @"name", @"age"];
    XCTAssertEqualObjects(self.table.headers, expect, @"");
}

- (void)testRows
{
    NSArray *expect = @[
        @{@"id": @1, @"name": @"Alice", @"age": @18},
        @{@"id": @2, @"name": @"Bob", @"age": @19},
        @{@"id": @3, @"name": @"Charlie", @"age": @20}
    ];
    XCTAssertEqualObjects(self.table.rows, expect, @"");
}

@end
