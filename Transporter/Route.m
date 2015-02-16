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
        
        // If we have a colour from the API, use it.
        // Only temporary so forgive the awfulness.
        if (![dictionary[@"color"] isEqual:[NSNull null]]) {
            
            NSInteger index = [dictionary[@"color"] integerValue];
            NSArray *colours = [Route colors];

            if (index <= colours.count) {
                _color = colours[index];
            } else {
                _color = nil;
            }

        } else {
            _color = nil;
        }
    }
    
    return self;
}

- (UIColor *)color
{
    if (!_color) {
        
        NSArray *colours = [Route colors];
        UIColor *color = colours[self.shortName.hash % colours.count];
        
        return color;
        
    } else {
        return _color;
    }
}

+ (NSArray *)colors
{
    // Load these from a nice Info.plist sometime...
    NSArray *colours = @[
                         [UIColor colorWithRed:0.87 green:0.29 blue:0.3 alpha:1],
                         [UIColor colorWithRed:0.88 green:0.48 blue:0.27 alpha:1],
                         [UIColor colorWithRed:0.93 green:0.78 blue:0.34 alpha:1],
                         [UIColor colorWithRed:0.29 green:0.69 blue:0.62 alpha:1],
                         [UIColor colorWithRed:0.2 green:0.3 blue:0.36 alpha:1],
                         [UIColor colorWithRed:0.16 green:0.53 blue:0.76 alpha:1]];
    return colours;
}

@end
