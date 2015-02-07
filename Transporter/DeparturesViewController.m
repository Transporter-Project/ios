//
//  DeparturesViewController.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DeparturesViewController.h"
#import "TransporterKit.h"
#import "DepartureDetailViewController.h"
#import "LocationSearchViewController.h"

@interface DeparturesViewController ()

@end

@implementation DeparturesViewController

- (instancetype)init
{
    if (self = [super initWithStyle:EKTableViewStylePlain]) {
        
        _departureController = [[AppController sharedController] departureController];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchBar.barTintColor = [UIColor blackColor];
    self.navigationItem.titleView = self.searchBar;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self reload];
}

- (void)reload
{
    [self.departureController departuresNearCurrentLocationWithCompletion:^(NSArray *departures, NSArray *routes, NSArray *stops, CLLocation *location, NSError *error) {
        
        self.view.backgroundColor = [[[departures firstObject] route] color];
        
        EKTableSection *departureSection = [EKTableSection sectionWithHeaderTitle:nil rows:departures footerTitle:nil selection:^(EKTableRowSelection *selection) {
            
            Departure *departure = (Departure *)selection.object;
            [self handleDeparture:departure];
        }];
        
        CLGeocoder *geocoder = [CLGeocoder new];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            
            CLPlacemark *placemark = [placemarks firstObject];
            
            self.searchBar.text = placemark.name;
        }];
        
        [self addSection:departureSection];
        [self.tableView reloadData];
    }];
}

- (void)handleDeparture:(Departure *)departure
{    
    DepartureDetailViewController *viewController = [[DepartureDetailViewController alloc] initWithDeparture:departure];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UIColor *)navigationBarColor
{
    return [UIColor clearColor];
}

@end
