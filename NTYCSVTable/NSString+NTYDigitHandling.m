//
//  NSString+NTYDigitHandling.m
//  NTYCSVTable
//
//  Created by Naoto Kaneko on 2014/04/15.
//  Copyright (c) 2014 Naoto Kaneko. All rights reserved.
//

#import "NSString+NTYDigitHandling.h"

@implementation NSString (NTYDigitHandling)

static NSCharacterSet *digitCharacterSet = nil;

+ (void)load
{
    if (!digitCharacterSet) {
        digitCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
}

- (BOOL)isDigit
{
    NSScanner *scanner = [NSScanner localizedScannerWithString:self];
    scanner.charactersToBeSkipped = NO;
    [scanner scanCharactersFromSet:digitCharacterSet intoString:NULL];
    return scanner.isAtEnd;
}

@end
