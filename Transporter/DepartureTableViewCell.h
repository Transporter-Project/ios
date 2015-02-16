//
//  DepartureTableViewCell.h
//  Transporter
//
//  Created by Phillip Caudell on 06/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Departure;

@interface DepartureTableViewCell : UITableViewCell

@property (nonatomic, strong) Departure *departure;
@property (nonatomic, strong) UILabel *departureLabel;
@property (nonatomic, strong) UILabel *stopLabel;
@property (nonatomic, strong) UIProgressView *departureProgressView;

@end
