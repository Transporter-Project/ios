//
//  AppController.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "AppController.h"
#import "TransporterKit.h"

@implementation AppController

static AppController *sharedController = nil;

+ (AppController *)sharedController
{
    @synchronized(self) {
        if (sharedController == nil) {
            sharedController = [[self alloc] init];
        }
    }
    
    return sharedController;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _departureController = [[DepartureController alloc] init];
    }
    
    return self;
}

@end
