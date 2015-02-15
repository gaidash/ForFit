//
//  Food.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 28.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import "Food.h"

@implementation Food

#pragma mark - NSCoding Protocol
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.calories forKey:@"calories"];
    [aCoder encodeObject:self.imageNameString forKey:@"imageNameString"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.calories = [aDecoder decodeIntForKey:@"calories"];
        self.imageNameString = [aDecoder decodeObjectForKey:@"imageNameString"];
    }
    return self;
}

@end