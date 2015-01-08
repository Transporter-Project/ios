//
//  RouteDeparturesViewController.m
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "RouteDeparturesViewController.h"
#import "TransporterKit.h"
#import "DepartureTimelinePoint.h"

@interface RouteDeparturesViewController ()

@end

@implementation RouteDeparturesViewController

- (id)initWithStop:(Stop *)stop route:(Route *)route
{
    if (self = [super init]) {
        
        _stop = stop;
        _route = route;
        _departureController = [[AppController sharedController] departureController];

        self.title = route.shortName;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [self.departureController departuresForStop:self.stop withRoute:self.route completion:^(NSArray *departures, NSArray *routes, NSArray *stops, NSError *error) {
        
        NSMutableArray *departureTimelinePoints = [NSMutableArray array];
        
        [departures enumerateObjectsUsingBlock:^(Departure *departure, NSUInteger idx, BOOL *stop) {
            
            DepartureTimelinePoint *point = [DepartureTimelinePoint new];
            point.departureDate = departure.departureDate;
            
            [departureTimelinePoints addObject:point];
        }];
        
        EKTableSection *departureSection = [EKTableSection sectionWithHeaderTitle:nil rows:departureTimelinePoints footerTitle:nil selection:nil];
        [self addSection:departureSection];
        [self.tableView reloadData];
    }];
}

@end
