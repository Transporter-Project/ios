//
//  DepartureController.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureController.h"
#import "TransporterKit.h"  

@implementation DepartureController

- (instancetype)init
{
    if (self = [super init]) {
        
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:TPAPIBaseAddress]];
        
        _locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    return self;
}

- (void)departuresNearCurrentLocationWithCompletion:(DepartureCompletion)completion
{
    [self departuresNearCoordinate:CLLocationCoordinate2DMake(50.719687, -1.885315) completion:completion];
}

- (void)departuresNearCoordinate:(CLLocationCoordinate2D)coordinate completion:(DepartureCompletion)completion
{    
    NSMutableDictionary *query = [NSMutableDictionary new];
    query[@"lat"] = @(coordinate.latitude);
    query[@"lon"] = @(coordinate.longitude);
    
    [self departuresWithOptions:query completion:completion];
}

- (void)departuresForStop:(Stop *)stop withRoute:(Route *)route completion:(DepartureCompletion)completion
{
    NSMutableDictionary *query = [NSMutableDictionary new];
    query[@"stop_id"] = stop.identifier;

    if (route) {
        query[@"route_id"] = route.identifier;
    }
    
    [self departuresWithOptions:query completion:completion];
}

- (void)departuresWithOptions:(NSDictionary *)query completion:(DepartureCompletion)completion
{
    [self.requestManager GET:@"departures" parameters:query success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSArray *stops = [Model modelsWithDictionaries:responseObject[@"stops"] rootClass:[Stop class]];
        NSArray *routes = [Model modelsWithDictionaries:responseObject[@"routes"] rootClass:[Route class]];
        
        NSArray *departures = [Model modelsWithDictionaries:responseObject[@"departures"] rootClass:[Departure class] custom:^(Departure *departure, NSDictionary *dictionary) {
            
            [stops enumerateObjectsUsingBlock:^(Stop *stop, NSUInteger idx, BOOL *s) {
                
                if ([stop.identifier isEqualToString:dictionary[@"stop_id"]]) {
                    departure.stop = stop;
                }
            }];
            
            [routes enumerateObjectsUsingBlock:^(Route *route, NSUInteger idx, BOOL *s) {
                
                if ([route.identifier isEqualToString:dictionary[@"route_id"]]) {
                    departure.route = route;
                }
            }];
        }];
        
        CLLocation *originLocation = nil;
        
        // Construct coordiante
        if (query[@"lat"] && query[@"lon"]) {
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([query[@"lat"] doubleValue], [query[@"lon"] doubleValue]);
            originLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        }
        
        completion(departures, routes, stops, originLocation, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        completion(nil, nil, nil, nil, error);
    }];
}

- (void)tripDetailsForDeparture:(Departure *)departure completion:(TripDetailsCompletion)completion
{
    [self.requestManager GET:[NSString stringWithFormat:@"trips/%@", departure.tripId] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSArray *stops = [Model modelsWithDictionaries:responseObject[@"stops"] rootClass:[Stop class]];
        NSArray *times = [Model modelsWithDictionaries:responseObject[@"times"] rootClass:[TripCallingPoint class] custom:^(TripCallingPoint *tripCallingPoint, NSDictionary *dictionary) {
            
            [stops enumerateObjectsUsingBlock:^(Stop *stop, NSUInteger idx, BOOL *s) {
                
                if ([stop.identifier isEqualToString:dictionary[@"stop_id"]]) {
                    tripCallingPoint.stop = stop;
                }
            }];
        }];
        
        completion(times, stops, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - Location

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}

@end
