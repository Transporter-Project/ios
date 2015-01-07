//
//  DepartureDetailViewController.h
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Departure;
@class DepartureController;

@interface DepartureDetailViewController : UIViewController <MKMapViewDelegate>

@property (readonly, strong) Departure *departure;
@property (readonly, strong) MKMapView *mapView;
@property (readonly, strong) DepartureController *departureController;

- (instancetype)initWithDeparture:(Departure *)depature;

@end
