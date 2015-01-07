//
//  TripCallingPoint.m
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "TripCallingPoint.h"
#import "TransporterKit.h"

@implementation TripCallingPoint

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary:dictionary]) {
        
        _stopSequence = [dictionary[@"stop_sequence"] integerValue];
        _arrivalDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"arrival"] integerValue]];
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.stop.location.coordinate;
}

- (NSString *)title
{
    return self.stop.title;
}

- (NSString *)subtitle
{
    return self.arrivalDate.description;
}

@end
