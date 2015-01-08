//
//  DepartureTimelinePoint.h
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LightningTable.h"

@interface DepartureTimelinePoint : NSObject <EKTableRowProtocol>

@property (nonatomic, strong) NSDate *departureDate;
@property (nonatomic, assign) NSInteger timeDelta;
@property (nonatomic, assign) NSInteger lowestDelta;

@end
