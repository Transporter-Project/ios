//
//  DepartureDetailViewController.h
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NavigationBarController.h"

@class Departure;
@class DepartureController;

@interface DepartureDetailViewController : UIViewController <MKMapViewDelegate, NavigationBarControllerDelegate>

@property (readonly, strong) Departure *departure;
@property (readonly, strong) MKMapView *mapView;
@property (readonly, strong) DepartureController *departureController;
@property (readonly, strong) UIView *detailBarView;
@property (readonly, strong) UILabel *headsignLabel;
@property (readonly, strong) UILabel *stopLabel;

- (instancetype)initWithDeparture:(Departure *)depature;

@end
