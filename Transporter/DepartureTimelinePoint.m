//
//  DepartureTimelinePoint.m
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureTimelinePoint.h"

@implementation DepartureTimelinePoint

- (NSString *)rowTitle
{
    return self.departureDate.description;
}

@end
