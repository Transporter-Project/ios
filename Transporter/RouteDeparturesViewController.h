//
//  RouteDeparturesViewController.h
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "EKTableViewController.h"

@class Stop;
@class Route;
@class DepartureController;

@interface RouteDeparturesViewController : EKTableViewController

@property (readonly, strong) Stop *stop;
@property (readonly, strong) Route *route;
@property (readonly, strong) DepartureController *departureController;

- (id)initWithStop:(Stop *)stop route:(Route *)route;

@end
