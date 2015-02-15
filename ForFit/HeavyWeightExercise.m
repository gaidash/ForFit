//
//  HeavyWeightExercise.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 01.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "HeavyWeightExercise.h"

@implementation HeavyWeightExercise

#pragma mark - NSCoding Protocol
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.note forKey:@"note"];
    [aCoder encodeObject:self.weightsRepsArray forKey:@"weightsRepsArray"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.note = [aDecoder decodeObjectForKey:@"note"];
        self.weightsRepsArray = [aDecoder decodeObjectForKey:@"weightsRepsArray"];
    }
    return self;
}


@end