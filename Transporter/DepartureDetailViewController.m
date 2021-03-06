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
#import "DepartureBarView.h"
#import "NavigationBarController.h"

@implementation DepartureDetailViewController

- (instancetype)initWithDeparture:(Departure *)depature
{
    if (self = [super init]) {
        
        _departure = depature;
        _departureController = [[AppController sharedController] departureController];

        self.title = depature.route.shortName;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BarButtonItem-Time"] style:UIBarButtonItemStylePlain target:self action:@selector(handleOtherTimes:)];
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
    
    _departureBarView = [DepartureBarView new];
    self.departureBarView.headsignLabel.text = self.departure.headsign;
    self.departureBarView.stopLabel.text = self.departure.stop.title;
    
    self.departureBarView.backgroundColor = self.departure.route.color;
    [self.view addSubview:self.departureBarView];
    
    self.view.backgroundColor = self.departure.route.color;
    
    [self reload];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.mapView.frame = self.view.bounds;
    self.departureBarView.frame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height + 20, self.view.bounds.size.width, 50);
}

- (void)reload
{
    self.mapView.alpha = 0.0;
    self.loading = YES;
    
    [self.departureController tripDetailsForDeparture:self.departure completion:^(NSArray *callingPoints, NSArray *stops, NSError *error) {
    
        self.loading = NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.mapView.alpha = 1.0;
        }];
        
        [self.mapView addAnnotations:callingPoints];
        [self drawRouteWithCallingPoints:callingPoints];
    
        [UIView animateKeyframesWithDuration:0.0 delay:0.5 options:kNilOptions animations:^{
            
            
        } completion:^(BOOL finished) {
            
            [self showUserAndStopAnimated:YES];
        }];
    }];
}

#pragma mark - Loading

- (BOOL)isLoading
{
    return self.loading;
}

- (void)setLoading:(BOOL)loading
{
    [self willChangeValueForKey:@"loading"];
    _loading = loading;
    [self setNeedsActivityIndicatorUpdate];
    [self didChangeValueForKey:@"loading"];
}

#pragma mark - Actions

- (void)handleOtherTimes:(id)sender
{
    RouteDeparturesViewController *viewController = [[RouteDeparturesViewController alloc] initWithStop:self.departure.stop route:self.departure.route];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Map

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

- (void)showUserAndStopAnimated:(BOOL)animated
{
    __block MKUserLocation *userLocation = nil;
    
    [self.mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[MKUserLocation class]]) {
            userLocation = obj;
        }
    }];
    
    if (userLocation) {
        
        [UIView animateWithDuration:2.0 animations:^{
            [self.mapView showAnnotations:@[userLocation, self.departure.stop] animated:animated];
        }];
    }
}

#pragma mark - Navigation bar delegate

- (UIColor *)navigationBarColor
{
    return self.departure.route.color;
}

@end
