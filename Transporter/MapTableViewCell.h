//
//  MapTableViewCell.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTableViewCell : UITableViewCell

@property (readonly, strong) MKMapView *mapView;

@end
