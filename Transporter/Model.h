//
//  Model.h
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

typedef void (^ModelCustomSetup)(id object, NSDictionary *dictionary);

@property (readonly, strong) NSString *identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)modelsWithDictionaries:(NSArray *)dictionaries rootClass:(Class)rootClass;
+ (NSArray *)modelsWithDictionaries:(NSArray *)dictionaries rootClass:(Class)rootClass custom:(ModelCustomSetup)custom;

@end
