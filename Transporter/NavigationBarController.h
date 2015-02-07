//
//  NavigationViewController.h
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBarController : UINavigationController <UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *navigationBarBackground;

@end

@protocol NavigationBarControllerDelegate <NSObject>

- (UIColor *)navigationBarColor;

@end