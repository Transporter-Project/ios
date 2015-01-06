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
    NSArray *colours = @[[UIColor colorWithRed:0.29 green:0.69 blue:0.62 alpha:1], [UIColor colorWithRed:0.87 green:0.29 blue:0.3 alpha:1], [UIColor colorWithRed:0.88 green:0.48 blue:0.27 alpha:1], [UIColor colorWithRed:0.93 green:0.78 blue:0.34 alpha:1]];
    
    return colours[self.shortName.hash % colours.count];
}

@end
