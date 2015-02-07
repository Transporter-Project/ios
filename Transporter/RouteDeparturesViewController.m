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
#import "PCAngularActivityIndicatorView.h"
#import "DepartureBarView.h"

@interface RouteDeparturesViewController ()

@property (nonatomic, strong) PCAngularActivityIndicatorView *activityIndicatorView;

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
    self.departureBarView.stopLabel.text = self.stop.title;
    self.departureBarView.backgroundColor = self.route.color;
    
    _activityIndicatorView = [[PCAngularActivityIndicatorView alloc] initWithActivityIndicatorStyle:PCAngularActivityIndicatorViewStyleLarge];
    self.activityIndicatorView.color = [UIColor whiteColor];
    [self.view addSubview:self.activityIndicatorView];
    
    self.view.backgroundColor = self.route.color;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    [self reload];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect activityFrame = self.activityIndicatorView.frame;
    activityFrame.origin.x = self.view.bounds.size.width / 2 - activityFrame.size.width / 2;
    activityFrame.origin.y = self.view.bounds.size.height / 2 - activityFrame.size.height;
    self.activityIndicatorView.frame = activityFrame;
}

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
    [self.activityIndicatorView startAnimating];
    
    [self.departureController departuresForStop:self.stop withRoute:self.route completion:^(NSArray *departures, NSArray *routes, NSArray *stops, CLLocation *location, NSError *error) {
        
        [self.activityIndicatorView stopAnimating];
        
        NSMutableArray *points = [NSMutableArray arrayWithCapacity:departures.count];
        NSMutableArray *pointDeltas = [NSMutableArray arrayWithCapacity:departures.count];
        __block NSInteger lowestPointDelta = MAXFLOAT;
        
        __block DepartureTimelinePoint *previousPoint = nil;
        
        [departures enumerateObjectsUsingBlock:^(Departure *departure, NSUInteger idx, BOOL *stop) {
            
            DepartureTimelinePoint *point = [DepartureTimelinePoint new];
            point.departureDate = departure.departureDate;
            
            if (previousPoint) {
                
                NSInteger pointDelta = [point.departureDate timeIntervalSinceDate:previousPoint.departureDate];
                
                if (pointDelta < lowestPointDelta) {
                    lowestPointDelta = pointDelta;
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
    }];

}

@end
