//
//  Route.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Model.h"
#import <UIKit/UIKit.h>

@interface Route : Model

@property (readonly, strong) NSString *shortName;
@property (readonly, strong) NSString *longName;
@property (nonatomic, strong) UIColor *color;

+ (NSArray *)colors;

@end
