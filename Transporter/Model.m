//
//  Model.m
//  Transporter
//
//  Created by Phillip Caudell on 05/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "Model.h"

@implementation Model

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        _identifier = dictionary[@"id"];
        
        for (NSString *key in dictionary.allKeys) {
            
            if ([self respondsToSelector:NSSelectorFromString(key)]) {
                [self setValue:dictionary[key] forKey:key];
            }
        }
    }
    
    return self;
}

+ (NSArray *)modelsWithDictionaries:(NSArray *)dictionaries rootClass:(Class)rootClass
{
    return [Model modelsWithDictionaries:dictionaries rootClass:rootClass custom:nil];
}

+ (NSArray *)modelsWithDictionaries:(NSArray *)dictionaries rootClass:(Class)rootClass custom:(ModelCustomSetup)custom
{
    if (![rootClass instancesRespondToSelector:@selector(initWithDictionary:)]) {
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:dictionaries.count];
    
    for (NSDictionary *dictionary in dictionaries) {
        
        id object = [[rootClass alloc] initWithDictionary:dictionary];
        
        if (custom) {
            custom(object, dictionary);
        }
        
        [objects addObject:object];
    }
    
    return objects;
}

@end
