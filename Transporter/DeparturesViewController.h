//
//  DeparturesViewController.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightningTable.h"

@class DepartureController;

@interface DeparturesViewController : EKTableViewController

@property (readonly, strong) DepartureController *departureController;

@end
