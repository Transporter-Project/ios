//
//  Departure.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Model.h"
#import "LightningTable.h"

@class Stop;
@class Route;

@interface Departure : Model <EKTableRowProtocol>

@property (readonly, strong) NSString *headsign;
@property (readonly, strong) NSDate *departureDate;
@property (readonly, strong) NSDate *arrivalDate;
@property (nonatomic, strong) Stop *stop;
@property (nonatomic, strong) Route *route;
@property (readonly, assign) NSInteger stopSequence;
@property (nonatomic, strong) NSString *tripId;

@end
