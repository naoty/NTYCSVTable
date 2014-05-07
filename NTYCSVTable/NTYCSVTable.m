//
//  NTYCSVTable.m
//  NTYCSVTable
//
//  Created by Naoto Kaneko on 2014/04/15.
//  Copyright (c) 2014 Naoto Kaneko. All rights reserved.
//

#import "NTYCSVTable.h"
#import "NSString+NTYNonStringHandling.h"

@interface NTYCSVTable ()
@property (nonatomic) NSArray *headers;
@property (nonatomic) NSArray *rows;
@property (nonatomic) NSDictionary *columns;
@property (nonatomic) NSString *columnSeperator;
@end

@implementation NTYCSVTable

- (id)initWithContentsOfURL:(NSURL *)url columnSeparator:(NSString *)separator {
    self = [super init];
    if (self) {
        self.columnSeperator = separator;
        NSString *csvString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        csvString = [csvString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSArray *lines = [csvString componentsSeparatedByString:@"\n"];
        [self parseHeadersFromLines:lines];
        [self parseRowsFromLines:lines];
        [self parseColumnsFromLines:lines];
    }
    return self;
}

- (id)initWithContentsOfURL:(NSURL *)url
{
    return [self initWithContentsOfURL:url columnSeparator:@","];
}

- (NSArray *)rowsOfValue:(id)value forHeader:(NSString *)header
{
    NSPredicate *predicate = [NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionForKeyPath:header]
                                                                rightExpression:[NSExpression expressionForConstantValue:value]
                                                                       modifier:NSDirectPredicateModifier
                                                                           type:NSEqualToPredicateOperatorType
                                                                        options:0];
    return [self.rows filteredArrayUsingPredicate:predicate];
}

#pragma mark - Private methods

- (void)parseHeadersFromLines:(NSArray *)lines
{
    NSString *headerLine = lines.firstObject;
    self.headers = [headerLine componentsSeparatedByString:self.columnSeperator];
}

- (void)parseRowsFromLines:(NSArray *)lines
{
    NSMutableArray *rows = [NSMutableArray new];
    for (NSString *line in lines) {
        NSInteger lineNumber = [lines indexOfObject:line];
        if (lineNumber == 0) {
            continue;
        }
        
        NSArray *values = [line componentsSeparatedByString:self.columnSeperator];
        NSMutableDictionary *row = [NSMutableDictionary new];
        for (NSString *header in self.headers) {
            NSUInteger index = [self.headers indexOfObject:header];
            NSString *value = values[index];
            if ([value isDigit]) {
                row[header] = [NSNumber numberWithLongLong:value.longLongValue];
            } else if ([value isBoolean]) {
                row[header] = [NSNumber numberWithBool:value.boolValue];
            } else {
                row[header] = values[index];
            }
        }
        [rows addObject:[NSDictionary dictionaryWithDictionary:row]];
    }
    self.rows = [NSArray arrayWithArray:rows];
}

- (void)parseColumnsFromLines:(NSArray *)lines
{
    NSMutableDictionary *columns = [NSMutableDictionary new];
    for (NSString *header in self.headers) {
        NSMutableArray *values = [NSMutableArray new];
        for (NSDictionary *row in self.rows) {
            [values addObject:row[header]];
        }
        columns[header] = [NSArray arrayWithArray:values];
    }
    self.columns = [NSDictionary dictionaryWithDictionary:columns];
}

@end
