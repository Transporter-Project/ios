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
        _shortName = dictionary[@"short_name"];
    }
    
    return self;
}

@end
