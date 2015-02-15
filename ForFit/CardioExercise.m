//
//  CardioExercise.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 04.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "CardioExercise.h"

@implementation CardioExercise

#pragma mark - NSCoding Protocol
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.exerciseType forKey:@"exerciseType"];
    [aCoder encodeObject:self.distance forKey:@"distance"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.caloriesBurned forKey:@"caloriesBurned"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.exerciseType = [aDecoder decodeObjectForKey:@"exerciseType"];
        self.distance = [aDecoder decodeObjectForKey:@"distance"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.caloriesBurned = [aDecoder decodeObjectForKey:@"caloriesBurned"];
    }
    return self;
}

@end