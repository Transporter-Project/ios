//
//  Stop.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Stop.h"

@implementation Stop

#pragma mark - MKAnnotation

- (NSString *)title
{
    return self.name;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

@end
