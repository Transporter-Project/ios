//
//  HighlightView.m
//  Transporter
//
//  Created by Phillip Caudell on 06/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "HighlightView.h"

@implementation HighlightView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.topHighlightView = [UIView new];
        self.topHighlightView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        [self addSubview:self.topHighlightView];
        
        self.bottomHightlightView = [UIView new];
        self.bottomHightlightView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self addSubview:self.bottomHightlightView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topHighlightView.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
    self.bottomHightlightView.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
}

@end
