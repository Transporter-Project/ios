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
#import "TitleViewNavigationItemView.h"
#import "NavigationBarController.h"

@interface DeparturesViewController ()

@property (nonatomic, assign) NSInteger currentColorIndex;
@property (nonatomic, strong) NSTimer *colorTimer;
@property (nonatomic, strong) TitleViewNavigationItemView *titleView;

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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _titleView = [TitleViewNavigationItemView new];
    self.navigationItem.titleView = self.titleView;
    
    [self reload];
    [self updateBackgroundColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.titleView.frame = self.navigationController.navigationBar.bounds;
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
    
    [self setNeedsActivityIndicatorUpdate];

    [super didChangeValueForKey:@"loading"];
}

- (BOOL)isLoading
{
    return self.loading;
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
            
            self.titleView.titleLabel.text = placemark.name;
            self.titleView.detailLabel.text = placemark.subAdministrativeArea;
            [self.titleView animateIn];
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
        
        [UIView animateWithDuration:0.6 delay:0.1 * idx usingSpringWithDamping:0.85 initialSpringVelocity:0.9 options:kNilOptions animations:^{
            
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
    return [[UIColor blackColor] colorWithAlphaComponent:0.4];
}

@end
