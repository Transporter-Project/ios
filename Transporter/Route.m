//
//  Route.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Route.h"

@implementation Route

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary:dictionary]) {
        
        _longName = dictionary[@"long_name"];
        _shortName = [dictionary[@"short_name"] lowercaseString];
    }
    
    return self;
}

- (UIColor *)color
{
    NSArray *colours = @[[UIColor colorWithRed:0.18 green:0.6 blue:0.65 alpha:1], [UIColor colorWithRed:0.67 green:0.82 blue:0.4 alpha:1], [UIColor colorWithRed:0.97 green:0.78 blue:0.26 alpha:1], [UIColor colorWithRed:0.94 green:0.35 blue:0.31 alpha:1]];
    
    return colours[self.shortName.hash % colours.count];
}

@end
