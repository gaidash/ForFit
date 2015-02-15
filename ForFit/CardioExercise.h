//
//  CardioExercise.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 04.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardioExercise : NSObject <NSCoding>

@property (nonatomic, copy) NSString *exerciseType;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *caloriesBurned;

@end