//
//  Stop.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Stop.h"

@implementation Stop

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary:dictionary]) {
        
        CLLocationDegrees latitude = [[dictionary[@"location"] lastObject] floatValue];
        CLLocationDegrees longitude = [[dictionary[@"location"] firstObject] floatValue];

        
        _location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }
    
    return self;
}

#pragma mark - MKAnnotation

- (NSString *)title
{
    return self.name;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

@end
