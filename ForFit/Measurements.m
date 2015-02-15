//
//  Measurements.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 05.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "Measurements.h"

@implementation Measurements

#pragma mark - NSCoding Protocol
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.measurementsArray forKey:@"measurementsArray"];
    [aCoder encodeObject:self.imageNameString forKey:@"imageNameString"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.measurementsArray = [aDecoder decodeObjectForKey:@"measurementsArray"];
        self.imageNameString = [aDecoder decodeObjectForKey:@"imageNameString"];
    }
    return self;
}

@end