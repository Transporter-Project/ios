//
//  DeparturesViewController.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LightningTable.h"
#import "NavigationBarController.h"

@class DepartureController;

@interface DeparturesViewController : EKTableViewController <NavigationBarControllerDelegate>

@property (readonly, strong) DepartureController *departureController;
@property (readonly, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@end
