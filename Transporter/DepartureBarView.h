//
//  DepartureBarView.h
//  Transporter
//
//  Created by Phillip Caudell on 07/02/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Departure;

@interface DepartureBarView : UIView

@property (nonatomic, strong) Departure *departure;

@property (readonly, strong) UILabel *headsignLabel;
@property (readonly, strong) UILabel *stopLabel;

@end
