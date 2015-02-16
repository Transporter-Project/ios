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
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TimelineTableRow-bg"]];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont fontWithName:@"OpenSans" size:18];

        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
        
        self.centralLine = [UIView new];
        self.centralLine.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.centralLine];
        
        self.centralCircle = [UIView new];
        self.centralCircle.backgroundColor = [UIColor blueColor];
        self.centralCircle.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.centralCircle.layer.borderWidth = 2.0;
        [self.contentView addSubview:self.centralCircle];
    }
    
    return self;
}

- (void)setPoint:(DepartureTimelinePoint *)point
{
    [self willChangeValueForKey:@"point"];
    
    _point = point;
    self.textLabel.text = [self.dateFormatter stringFromDate:point.departureDate];
    self.centralCircle.backgroundColor = point.color;
    
    [self didChangeValueForKey:@"point"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.size.width = self.contentView.bounds.size.width - 30;
    self.textLabel.frame = textLabelFrame;
    
    if (self.point.odd) {
        self.textLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        self.textLabel.textAlignment = NSTextAlignmentRight;
    }
    
    self.centralLine.frame = CGRectMake(self.contentView.frame.size.width / 2 - 1, 0, 2, self.contentView.frame.size.height);
    self.centralCircle.frame = CGRectMake(0, 0, 20, 20);
    self.centralCircle.center = self.contentView.center;
    self.centralCircle.layer.cornerRadius = self.centralCircle.frame.size.height / 2;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
