//
//  Departure.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Departure.h"
#import "TransporterKit.h"

@implementation Departure

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary:dictionary]) {
        
        _departureDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"departure"] integerValue]];
        _arrivalDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"arrival"] integerValue]];
        _stopSequence = [dictionary[@"stop_sequence"] integerValue];
    }
    
    return self;
}

#pragma mark - Row

- (NSString *)rowTitle
{
    return self.route.shortName;
}

- (NSString *)rowSubtitle
{
    return self.headsign;
}

@end
