//
//  AppController.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DepartureController;

@interface AppController : NSObject

@property (readonly, strong) DepartureController *departureController;

+ (AppController *)sharedController;

@end
