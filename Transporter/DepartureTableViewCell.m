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
        self.textLabel.font = [UIFont systemFontOfSize:24];
        
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:14];
        
        self.departureLabel = [UILabel new];
        self.departureLabel.textColor = [UIColor whiteColor];
        self.departureLabel.font = [UIFont systemFontOfSize:24];
        [self.contentView addSubview:self.departureLabel];
    }
    
    return self;
}

- (void)setDeparture:(Departure *)departure
{
    [self willChangeValueForKey:@"departure"];
    
    _departure = departure;
    
    self.textLabel.text = self.departure.route.shortName;
    self.detailTextLabel.text = self.departure.headsign;
    self.backgroundColor = self.departure.route.color;
    self.departureLabel.text = [self.departure.departureDate timeAgoSimple];
    
    [self didChangeValueForKey:@"departure"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.highlightView.frame = self.contentView.bounds;
    self.departureLabel.frame = CGRectMake(self.contentView.bounds.size.width - 60, 0, 60, self.contentView.bounds.size.height);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

@end
