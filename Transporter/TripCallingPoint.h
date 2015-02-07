//
//  TripCallingPoint.h
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Model.h"
#import <MapKit/MapKit.h>

@class Stop;

@interface TripCallingPoint : Model <MKAnnotation>

@property (readonly, assign) NSInteger stopSequence;
@property (nonatomic, strong) Stop *stop;
@property (readonly, strong) NSDate *arrivalDate;

@end
