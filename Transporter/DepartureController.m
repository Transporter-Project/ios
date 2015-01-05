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
    }
    
    return self;
}

- (void)departuresNearCoordinate:(CLLocationCoordinate2D)coordinate completion:(DepartureCompletion)completion
{    
    NSMutableDictionary *query = [NSMutableDictionary new];
    query[@"lat"] = @(coordinate.latitude);
    query[@"lon"] = @(coordinate.longitude);
    
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
        
        completion(departures, routes, stops, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        completion(nil, nil, nil, error);
    }];
}

@end
