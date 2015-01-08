//
//  RouteDeparturesViewController.m
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "RouteDeparturesViewController.h"
#import "TransporterKit.h"

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
        
        EKTableSection *departureSection = [EKTableSection sectionWithHeaderTitle:nil rows:departures footerTitle:nil selection:nil];
        [self addSection:departureSection];
        [self.tableView reloadData];
    }];
}

@end
