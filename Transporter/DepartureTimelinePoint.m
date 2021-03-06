//
//  DepartureTimelinePoint.m
//  Transporter
//
//  Created by Phillip Caudell on 08/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "DepartureTimelinePoint.h"
#import "DepartureTimelineTableViewCell.h"

@implementation DepartureTimelinePoint

- (void)configureRowCell:(DepartureTimelineTableViewCell *)cell
{
    cell.point = self;
}

- (Class)rowCellClass
{
    return [DepartureTimelineTableViewCell class];
}

- (CGFloat)rowHeightForConstraintSize:(CGSize)contraintSize
{
    // This logic is deeply flawed, but I'm too tired to work out why.
    // It can result in very very large gaps. Blah.

    NSInteger height = (self.timeDelta / self.lowestDelta) * 44;
    
    if (height < 44) {
        height = 44;
    }
    
    if (height > contraintSize.height) {
        height = contraintSize.height - (contraintSize.height / 6);
    }
    
    return height;
}

@end
