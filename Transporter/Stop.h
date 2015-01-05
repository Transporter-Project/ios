//
//  Stop.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Model.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Stop : Model <MKAnnotation>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) CLLocation *location;

@end
