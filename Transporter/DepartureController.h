//
//  DepartureController.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import <CoreLocation/CoreLocation.h>

@class Departure;
@class Route;
@class Stop;

@interface DepartureController : NSObject <CLLocationManagerDelegate>

typedef void (^DepartureCompletion)(NSArray *departures, NSArray *routes, NSArray *stops, NSError *error);
typedef void (^TripDetailsCompletion)(NSArray *callingPoints, NSArray *stops, NSError *error);

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;
@property (readonly, strong) CLLocationManager *locationManager;

- (void)departuresNearCurrentLocationWithCompletion:(DepartureCompletion)completion;
- (void)departuresNearCoordinate:(CLLocationCoordinate2D)coordinate completion:(DepartureCompletion)completion;
- (void)tripDetailsForDeparture:(Departure *)departure completion:(TripDetailsCompletion)completion;
- (void)departuresForStop:(Stop *)stop withRoute:(Route *)route completion:(DepartureCompletion)completion;

@end
