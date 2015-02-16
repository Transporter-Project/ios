//
//  MapTableRow.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "MapTableRow.h"
#import "MapTableViewCell.h"

@implementation MapTableRow

- (Class)rowCellClass
{
    return [MapTableViewCell class];
}

- (CGFloat)rowHeightForConstraintSize:(CGSize)contraintSize
{
    return 300;
}

- (void)configureRowCell:(MapTableViewCell *)cell
{
    [cell.mapView removeAnnotations:cell.mapView.annotations];
    [cell.mapView addAnnotations:self.annotations];
    [cell.mapView showAnnotations:self.annotations animated:NO];
    
    cell.mapView.showsUserLocation = self.showsUserLocation;
}

@end
