//
//  MapTableRow.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LightningTable.h"

@interface MapTableRow : NSObject <EKTableRowProtocol>

@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, assign) BOOL showsUserLocation;

@end
