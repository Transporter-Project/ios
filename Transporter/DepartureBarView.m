//
//  DepartureBarView.m
//  Transporter
//
//  Created by Phillip Caudell on 07/02/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureBarView.h"
#import "TransporterKit.h"  

@implementation DepartureBarView

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectZero]) {
        
        _headsignLabel = [UILabel new];
        self.headsignLabel.textAlignment = NSTextAlignmentCenter;
        self.headsignLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14];
        self.headsignLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.headsignLabel];
        
        _stopLabel = [UILabel new];
        self.stopLabel.textAlignment = NSTextAlignmentCenter;
        self.stopLabel.font = [UIFont fontWithName:@"OpenSans" size:12];
        self.stopLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.stopLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headsignLabel.frame = CGRectMake(0, 0, self.bounds.size.width, 25);
    self.stopLabel.frame = CGRectMake(0, 20, self.bounds.size.width, 25);
}

- (void)setDeparture:(Departure *)departure
{
    [self willChangeValueForKey:@"departure"];
    
    _departure = departure;
    
    self.headsignLabel.text = self.departure.headsign;
    self.stopLabel.text = self.departure.stop.title;

    [self didChangeValueForKey:@"departure"];
}

@end
