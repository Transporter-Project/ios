//
//  Departure.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Departure.h"
#import "TransporterKit.h"
#import "DepartureTableViewCell.h"

@implementation Departure

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super initWithDictionary:dictionary]) {
        
        _departureDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"departure"] integerValue]];
        _arrivalDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"arrival"] integerValue]];
        _stopSequence = [dictionary[@"stop_sequence"] integerValue];
        _tripId = dictionary[@"trip_id"];
    }
    
    return self;
}

#pragma mark - Row

- (void)configureRowCell:(DepartureTableViewCell *)cell
{
    cell.departure = self;
}

- (CGFloat)rowHeightForConstraintSize:(CGSize)contraintSize
{
    return 100;
}

- (Class)rowCellClass
{
    return [DepartureTableViewCell class];
}

@end
