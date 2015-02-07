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

@property (nonatomic, assign) NSInteger currentColorIndex;
@property (nonatomic, strong) NSTimer *colorTimer;

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
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    _searchBar = [[UISearchBar alloc] init];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.barTintColor = [UIColor whiteColor];
    self.searchBar.placeholder = @"Locating...";
    self.searchBar.translucent = YES;
    self.navigationItem.titleView = self.searchBar;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self reload];
    [self updateBackgroundColor];
   
}

- (void)updateBackgroundColor
{
    NSArray *colors = [Route colors];
    
    if (self.currentColorIndex >= colors.count) {
        self.currentColorIndex = 0;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = colors[self.currentColorIndex];
    }];
    
    self.currentColorIndex ++;
}

- (void)setLoading:(BOOL)loading
{
    [super willChangeValueForKey:@"loading"];
    
    _loading = loading;
    
    if (loading) {
        
        self.colorTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateBackgroundColor) userInfo:nil repeats:YES];
    } else {
        
        [self.colorTimer invalidate];
        self.colorTimer = nil;
    }
    
    [super didChangeValueForKey:@"loading"];
}

- (void)reload
{
    self.loading = YES;
    
    [self.departureController departuresNearCurrentLocationWithCompletion:^(NSArray *departures, NSArray *routes, NSArray *stops, CLLocation *location, NSError *error) {
        
        self.loading = NO;
        
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
        
        [self animateCellsIn];
    }];
}

- (void)animateCellsIn
{
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        
        cell.transform = CGAffineTransformMakeTranslation(self.view.bounds.size.width, 0);
    }];
    
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        
        [UIView animateWithDuration:0.7 delay:0.15 * idx usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:kNilOptions animations:^{
            
            cell.transform = CGAffineTransformMakeTranslation(0, 0);
            
        } completion:nil];
    }];
}

- (void)handleDeparture:(Departure *)departure
{    
    DepartureDetailViewController *viewController = [[DepartureDetailViewController alloc] initWithDeparture:departure];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UIColor *)navigationBarColor
{
    return [[UIColor blackColor] colorWithAlphaComponent:0.1];
}

@end
