//
//  TitleViewNavigationItemView.h
//  Transporter
//
//  Created by Phillip Caudell on 07/02/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleViewNavigationItemView : UIView

@property (readonly, strong) UILabel *titleLabel;
@property (readonly, strong) UILabel *detailLabel;

- (void)animateIn;

@end
