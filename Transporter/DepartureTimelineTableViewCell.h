//
//  DepartureTimelineTableViewCell.h
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "EKTableViewCell.h"

@class DepartureTimelinePoint;

@interface DepartureTimelineTableViewCell : EKTableViewCell

@property (nonatomic, strong) DepartureTimelinePoint *point;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end
