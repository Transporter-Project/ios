//
//  DepartureTimelineTableViewCell.m
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureTimelineTableViewCell.h"
#import "DepartureTimelinePoint.h"  

@implementation DepartureTimelineTableViewCell

- (instancetype)initWithStyle:(EKTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    return self;
}

- (void)setPoint:(DepartureTimelinePoint *)point
{
    [self willChangeValueForKey:@"point"];
    
    _point = point;
    self.textLabel.text = [self.dateFormatter stringFromDate:point.departureDate];
    
    [self didChangeValueForKey:@"point"];
}

@end
