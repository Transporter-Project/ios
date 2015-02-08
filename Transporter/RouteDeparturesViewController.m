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
#import "DepartureBarView.h"
#import "NavigationBarController.h"

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
    _departureBarView = [DepartureBarView new];
    self.departureBarView.headsignLabel.text = self.route.longName;
    self.departureBarView.stopLabel.text = [NSString stringWithFormat:@"Departures from %@", self.stop.title];
    self.departureBarView.backgroundColor = self.route.color;
    
    self.view.backgroundColor = self.route.color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    [self reload];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

#pragma mark - Loading

- (BOOL)isLoading
{
    return self.loading;
}

- (void)setLoading:(BOOL)loading
{
    [self willChangeValueForKey:@"loading"];
    _loading = loading;
    [self setNeedsActivityIndicatorUpdate];
    [self didChangeValueForKey:@"loading"];
}

#pragma mark - Table View delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.departureBarView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)reload
{
    self.loading = YES;
    
    [self.departureController departuresForStop:self.stop withRoute:self.route completion:^(NSArray *departures, NSArray *routes, NSArray *stops, CLLocation *location, NSError *error) {
        
        self.loading = NO;
        
        NSMutableArray *points = [NSMutableArray arrayWithCapacity:departures.count];
        NSMutableArray *pointDeltas = [NSMutableArray arrayWithCapacity:departures.count];
        __block NSInteger lowestPointDelta = MAXFLOAT;
        
        __block DepartureTimelinePoint *previousPoint = nil;
        __block DepartureTimelinePoint *closestTimelinePoint = nil;
        
        NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];

        [departures enumerateObjectsUsingBlock:^(Departure *departure, NSUInteger idx, BOOL *stop) {
            
            DepartureTimelinePoint *point = [DepartureTimelinePoint new];
            point.departureDate = departure.departureDate;
            
            if (previousPoint) {
                
                NSInteger pointDelta = [point.departureDate timeIntervalSinceDate:previousPoint.departureDate];
                
                if (pointDelta < lowestPointDelta) {
                    lowestPointDelta = pointDelta;
                }
                
                if([point.departureDate timeIntervalSince1970] > currentTimeInterval && !closestTimelinePoint) {
                    closestTimelinePoint = point;
                }
                
                point.timeDelta = pointDelta;
                [pointDeltas addObject:@(pointDelta)];
            }
            
            [points addObject:point];
            previousPoint = point;
        }];
        
        [points enumerateObjectsUsingBlock:^(DepartureTimelinePoint *point, NSUInteger idx, BOOL *stop) {
            
            point.color = self.route.color;
            point.lowestDelta = lowestPointDelta;
            point.odd = idx % 2;
        }];
        
        EKTableSection *departureSection = [EKTableSection sectionWithHeaderTitle:nil rows:points footerTitle:nil selection:nil];
        [self addSection:departureSection];
        [self.tableView reloadData];
        
        NSInteger closestIndex = [points indexOfObject:closestTimelinePoint] - 1;
        
        if (closestIndex < 0) {
            closestIndex = 0;
        }
        
        NSIndexPath *closestTimelinePointIndexPath = [NSIndexPath indexPathForRow:closestIndex inSection:0];
        [self.tableView scrollToRowAtIndexPath:closestTimelinePointIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self animateCellsIn];
        [self.departureBarView animateIn];
    }];
}

- (void)animateCellsIn
{
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        cell.alpha = 0.0;
        cell.transform = CGAffineTransformMakeScale(0.8, 0.8);
    }];
    
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        
        [UIView animateWithDuration:0.4 delay:0.08 * idx options:kNilOptions animations:^{
            
            cell.alpha = 1.0;
            cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        } completion:nil];
    }];
}

@end
