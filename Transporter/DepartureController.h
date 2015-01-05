//
//  DepartureController.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>

@interface DepartureController : NSObject

typedef void (^DepartureCompletion)(NSArray *departures, NSArray *routes, NSArray *stops, NSError *error);

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

- (void)departuresNearCoordinate:(CLLocationCoordinate2D)coordinate completion:(DepartureCompletion)completion;

@end
