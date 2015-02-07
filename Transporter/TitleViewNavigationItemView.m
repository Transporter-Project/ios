//
//  TitleViewNavigationItemView.m
//  Transporter
//
//  Created by Phillip Caudell on 07/02/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "TitleViewNavigationItemView.h"

@implementation TitleViewNavigationItemView

- (instancetype)init
{
    if (self = [super init]) {
        
        _titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:18];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        _detailLabel = [UILabel new];
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.font = [UIFont fontWithName:@"OpenSans" size:12];
        [self addSubview:self.detailLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2);
    self.detailLabel.frame = CGRectMake(0, self.titleLabel.bounds.size.height, self.bounds.size.width, self.bounds.size.height / 2);
}

@end
