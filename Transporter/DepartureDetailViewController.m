//
//  DepartureDetailViewController.m
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureDetailViewController.h"
#import "TransporterKit.h"

@interface DepartureDetailViewController ()

@end

@implementation DepartureDetailViewController

- (instancetype)initWithDeparture:(Departure *)depature
{
    if (self = [super init]) {
        
        _departure = depature;
        _departureController = [[AppController sharedController] departureController];

        self.title = depature.route.shortName;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    [self.departureController tripDetailsForDeparture:self.departure completion:^(NSArray *callingPoints, NSArray *stops, NSError *error) {
        
        [self.mapView addAnnotations:callingPoints];
        [self drawRouteWithCallingPoints:callingPoints];
    }];
}

- (void)drawRouteWithCallingPoints:(NSArray *)callingPoints
{
    CLLocationCoordinate2D coordinates[callingPoints.count];
    
    for (int i = 0; i < callingPoints.count; ++i) {
        
        TripCallingPoint *point = callingPoints[i];
        coordinates[i] = point.stop.location.coordinate;
    }
    
    MKPolyline *centerLine = [MKPolyline polylineWithCoordinates:coordinates count:callingPoints.count];
    centerLine.title = @"center";
    
    MKPolyline *bottomLine = [MKPolyline polylineWithCoordinates:coordinates count:callingPoints.count];
    bottomLine.title = @"bottom";

    [self.mapView addOverlays:@[bottomLine, centerLine]];
    
    MKMapRect mapRect = [self.mapView mapRectThatFits:centerLine.boundingMapRect];
    [self.mapView setVisibleMapRect:mapRect edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:NO];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.mapView.frame = self.view.bounds;
}

#pragma mark - Map View delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];

    if ([[overlay title] isEqualToString:@"bottom"]) {
        
        renderer.lineWidth = 6.0;
        renderer.strokeColor = self.departure.route.color;
        
    } else {
        renderer.lineWidth = 3.0;
        renderer.strokeColor = [UIColor whiteColor];
    }

    return renderer;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"Marker"];
    
    if (!annotationView) {
        
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Marker"];
        annotationView.frame = CGRectMake(0, 0, 12, 12);
        annotationView.canShowCallout = YES;
        annotationView.backgroundColor = [UIColor whiteColor];
        annotationView.layer.borderWidth = 2.0;
        annotationView.layer.cornerRadius = 6;
        annotationView.layer.borderColor = self.departure.route.color.CGColor;
    }
    
    
    return annotationView;
}

@end
