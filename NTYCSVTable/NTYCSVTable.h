//
//  NTYCSVTable.h
//  NTYCSVTable
//
//  Created by Naoto Kaneko on 2014/04/15.
//  Copyright (c) 2014 Naoto Kaneko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTYCSVTable : NSObject

@property (nonatomic, readonly) NSArray *headers;
@property (nonatomic, readonly) NSArray *rows;

- (id)initWithContentsOfURL:(NSURL *)url;

@end
