//
//  DeparturesViewController.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DeparturesViewController.h"
#import "TransporterKit.h"

@interface DeparturesViewController ()

@end

@implementation DeparturesViewController

- (instancetype)init
{
    if (self = [super initWithStyle:EKTableViewStylePlain]) {
        
        self.title = @"Bournemouth";
        _departureController = [[AppController sharedController] departureController];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.departureController departuresNearCoordinate:CLLocationCoordinate2DMake(50.723526, -1.905179) completion:^(NSArray *departures, NSArray *routes, NSArray *stops, NSError *error) {
        
        EKTableSection *departureSection = [EKTableSection sectionWithHeaderTitle:nil rows:departures footerTitle:nil selection:^(EKTableRowSelection *selection) {
            
            
        }];
        
        [self addSection:departureSection];
        
        [self.tableView reloadData];
    }];
}

@end
