# NTYCSVTable

[![Version](http://cocoapod-badges.herokuapp.com/v/NTYCSVTable/badge.png)](http://cocoadocs.org/docsets/NTYCSVTable)
[![Platform](http://cocoapod-badges.herokuapp.com/p/NTYCSVTable/badge.png)](http://cocoadocs.org/docsets/NTYCSVTable)
[![Build Status](https://travis-ci.org/naoty/NTYCSVTable.svg?branch=master)](https://travis-ci.org/naoty/NTYCSVTable)

## Installation

NTYCSVTable is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

```ruby
platform :ios
pod "NTYCSVTable"
```

## Usage

For example, if you want to parse a below `users.csv`,

```csv
id,name,age
1,Alice,18
2,Bob,19
3,Charlie,20
```

you can access data by rows and columns like this.

```objective-c
NSURL *csvURL = [NSURL URLWithString:@"users.csv"];
NTYCSVTable *table = [NTYCSVTable alloc] initWithContentsOfURL:csvURL];

// Rows
NSArray *rows = table.rows;
NSArray *headers = table.headers;    //=> @[@"id", @"name", @"age"]
NSDictionary *alice = table.rows[0]; //=> @{@"id": @1, @"name": @"Alice", @"age": @18}
NSDictionary *bob = table.rows[1];   //=> @{@"id": @2, @"name": @"Bob", @"age": @19}

// Columns
NSDictionary *columns = table.columns;
NSArray *names = table.columns[@"name"]; //=> @[@"Alice", @"Bob", @"Charlie"]
NSArray *ages = table.columns[@"age"];   //=> @[@18, @19, @20]
```

Also, you can find rows which have a specified value for a specified header like this.

```objective-c
[table rowsOfValue:@1 forHeader:@"id"];  //=> @[@{@"id": @1, @"name": @"Alice", @"age": @18}]
[table rowsOfValue:@20 forHeader:@"age"] //=> @[@{@"id": @3, @"name": @"Charlie", @"age": @20}]
```

### Other formats

You can parse other formats such as TSV by using `initWithContentsOfURL:columnSeparator:`.

```objective-c
NSURL *tsvURL = [NSURL URLWithString:@"users.tsv"];
NTYCSVTable *table = [[NTYCSVTable alloc] initWithContentsOfURL:tsvURL columnSeparator:@"\t"];
```
