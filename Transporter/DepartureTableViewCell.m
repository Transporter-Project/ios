//
//  DepartureTableViewCell.m
//  Transporter
//
//  Created by Phillip Caudell on 06/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureTableViewCell.h"
#import "TransporterKit.h"  
#import "NSDate+TimeAgo.h"
#import "HighlightView.h"

@interface DepartureTableViewCell ()

@property (nonatomic, strong) HighlightView *highlightView;

@end

@implementation DepartureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        
        self.highlightView = [HighlightView new];
        [self.contentView addSubview:self.highlightView];
        
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont fontWithName:@"OpenSans" size:24];
        
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14];
        
        self.departureLabel = [UILabel new];
        self.departureLabel.textColor = [UIColor whiteColor];
        self.departureLabel.font = [UIFont fontWithName:@"OpenSans" size:24];
        [self.contentView addSubview:self.departureLabel];
        
        self.stopLabel = [UILabel new];
        self.stopLabel.textColor = [UIColor whiteColor];
        self.stopLabel.font = [UIFont fontWithName:@"OpenSans" size:12];
        [self.contentView addSubview:self.stopLabel];
     
        self.departureProgressView = [UIProgressView new];
        self.departureProgressView.progress = 0.5;
        self.departureProgressView.progressTintColor = [UIColor whiteColor];
        self.departureProgressView.trackTintColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self.contentView addSubview:self.departureProgressView];
       
    }
    
    return self;
}

- (void)setDeparture:(Departure *)departure
{
    [self willChangeValueForKey:@"departure"];
    
    _departure = departure;
    
    // Set labels
    self.textLabel.text = self.departure.route.shortName;
    self.detailTextLabel.text = self.departure.headsign;
    self.backgroundColor = self.departure.route.color;
    self.departureLabel.text = [self.departure.departureDate timeAgoSimple];
    self.stopLabel.text = self.departure.stop.name;
    
    // Set progress bar
    NSTimeInterval hoursTime = [[NSDate date] timeIntervalSince1970] + 3600;
    NSTimeInterval timeDelta = hoursTime - [departure.departureDate timeIntervalSince1970];

    self.departureProgressView.progress =  1.0 - (timeDelta / 3600);
 
    
    [self didChangeValueForKey:@"departure"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.highlightView.frame = self.contentView.bounds;
    self.departureLabel.frame = CGRectMake(self.contentView.bounds.size.width - 60, 0, 60, self.contentView.bounds.size.height);
    self.departureProgressView.frame = CGRectMake(self.contentView.bounds.size.width - 60, 70, 40, 2);
    
    self.stopLabel.frame = CGRectMake(15, 60, 200, 44);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

@end
