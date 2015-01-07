//
//  DeparturesViewController.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightningTable.h"
#import "NavigationBarController.h"

@class DepartureController;

@interface DeparturesViewController : EKTableViewController <NavigationBarControllerDelegate>

@property (readonly, strong) DepartureController *departureController;
@property (nonatomic, strong) UISearchController *searchController;

@end
