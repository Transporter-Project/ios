//
//  MapTableViewCell.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "MapTableViewCell.h"

@implementation MapTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _mapView = [MKMapView new];
        [self.contentView addSubview:self.mapView];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mapView.frame = self.contentView.bounds;
}

@end
