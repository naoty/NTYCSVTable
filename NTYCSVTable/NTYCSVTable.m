//
//  NTYCSVTable.m
//  NTYCSVTable
//
//  Created by Naoto Kaneko on 2014/04/15.
//  Copyright (c) 2014 Naoto Kaneko. All rights reserved.
//

#import "NTYCSVTable.h"
#import "NSString+NTYDigitHandling.h"

@interface NTYCSVTable ()
@property (nonatomic) NSArray *headers;
@property (nonatomic) NSArray *rows;
@end

@implementation NTYCSVTable

- (id)initWithContentsOfURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        NSString *csvString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        csvString = [csvString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSArray *lines = [csvString componentsSeparatedByString:@"\n"];
        [self parseHeadersFromLines:lines];
        [self parseRowsFromLines:lines];
    }
    return self;
}

#pragma mark - Private methods

- (void)parseHeadersFromLines:(NSArray *)lines
{
    NSString *headerLine = lines.firstObject;
    self.headers = [headerLine componentsSeparatedByString:@","];
}

- (void)parseRowsFromLines:(NSArray *)lines
{
    NSMutableArray *rows = [NSMutableArray new];
    for (NSString *line in lines) {
        NSInteger lineNumber = [lines indexOfObject:line];
        if (lineNumber == 0) {
            continue;
        }
        
        NSArray *cells = [line componentsSeparatedByString:@","];
        NSMutableDictionary *row = [NSMutableDictionary new];
        for (NSString *header in self.headers) {
            NSUInteger index = [self.headers indexOfObject:header];
            NSString *cell = cells[index];
            if ([cell isDigit]) {
                row[header] = [NSNumber numberWithInt:cell.intValue];
            } else {
                row[header] = cells[index];
            }
        }
        [rows addObject:[NSDictionary dictionaryWithDictionary:row]];
    }
    self.rows = [NSArray arrayWithArray:rows];
}

@end
