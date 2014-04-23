//
//  NSString+NTYNonStringHandling.m
//  NTYCSVTable
//
//  Created by Naoto Kaneko on 2014/04/15.
//  Copyright (c) 2014 Naoto Kaneko. All rights reserved.
//

#import "NSString+NTYNonStringHandling.h"

@implementation NSString (NTYNonStringHandling)

static NSCharacterSet *digitCharacterSet = nil;
static NSArray *booleanStrings = nil;

+ (void)load
{
    if (!digitCharacterSet) {
        digitCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    
    if (!booleanStrings) {
        booleanStrings = @[@"YES", @"NO", @"yes", @"no", @"TRUE", @"FALSE", @"true", @"false"];
    }
}

- (BOOL)isDigit
{
    NSScanner *scanner = [NSScanner localizedScannerWithString:self];
    scanner.charactersToBeSkipped = NO;
    [scanner scanCharactersFromSet:digitCharacterSet intoString:NULL];
    return scanner.isAtEnd;
}

- (BOOL)isBoolean
{
    return [booleanStrings containsObject:self];
}

@end
