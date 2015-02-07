//
//  DepartureDetailViewController.m
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureDetailViewController.h"
#import "TransporterKit.h"
#import "RouteDeparturesViewController.h"

@interface DepartureDetailViewController ()

@end

@implementation DepartureDetailViewController

- (instancetype)initWithDeparture:(Departure *)depature
{
    if (self = [super init]) {
        
        _departure = depature;
        _departureController = [[AppController sharedController] departureController];

        self.title = depature.route.shortName;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Other Times" style:UIBarButtonItemStylePlain target:self action:@selector(handleOtherTimes:)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    _detailBarView = [UIView new];
    self.detailBarView.backgroundColor = self.departure.route.color;
    [self.view addSubview:self.detailBarView];
    
    _headsignLabel = [UILabel new];
    self.headsignLabel.text = self.departure.headsign;
    self.headsignLabel.textAlignment = NSTextAlignmentCenter;
    self.headsignLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14];
    self.headsignLabel.textColor = [UIColor whiteColor];
    [self.detailBarView addSubview:self.headsignLabel];
    
    _stopLabel = [UILabel new];
    self.stopLabel.text = self.departure.stop.name;
    self.stopLabel.textAlignment = NSTextAlignmentCenter;
    self.stopLabel.font = [UIFont fontWithName:@"OpenSans" size:12];
    self.stopLabel.textColor = [UIColor whiteColor];
    [self.detailBarView addSubview:self.stopLabel];

    [self reload];
}

- (void)reload
{
    [self.departureController tripDetailsForDeparture:self.departure completion:^(NSArray *callingPoints, NSArray *stops, NSError *error) {
        
        [self.mapView addAnnotations:callingPoints];
        [self drawRouteWithCallingPoints:callingPoints];
    }];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.mapView.frame = self.view.bounds;
    self.detailBarView.frame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height + 20, self.view.bounds.size.width, 50);
    self.headsignLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, 25);
    self.stopLabel.frame = CGRectMake(0, 20, self.view.bounds.size.width, 25);
}

- (void)handleOtherTimes:(id)sender
{
    RouteDeparturesViewController *viewController = [[RouteDeparturesViewController alloc] initWithStop:self.departure.stop route:self.departure.route];
    [self.navigationController pushViewController:viewController animated:YES];
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
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"Marker"];
    
    if (!annotationView) {
        
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Marker"];
        annotationView.frame = CGRectMake(0, 0, 12, 12);
        annotationView.canShowCallout = YES;
        annotationView.layer.borderWidth = 2.0;
        annotationView.layer.cornerRadius = 6;
        annotationView.layer.borderColor = self.departure.route.color.CGColor;
    }
    
    TripCallingPoint *callingPoint = annotation;
    
    if ([annotation isKindOfClass:[TripCallingPoint class]]) {
        
        if ([callingPoint.stop.identifier isEqualToString:self.departure.stop.identifier]) {
            annotationView.backgroundColor = self.departure.route.color;
        } else {
            annotationView.backgroundColor = [UIColor whiteColor];
        }
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.mapView showAnnotations:@[userLocation, self.departure.stop] animated:YES];
}

#pragma mark - Navigation bar delegate

- (UIColor *)navigationBarColor
{
    return self.departure.route.color;
}

@end
