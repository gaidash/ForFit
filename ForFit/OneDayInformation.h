//
//  OneDayInformation.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 12.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CardioExercise.h"
#import "Measurements.h"


@interface OneDayInformation : NSManagedObject

@property (nonatomic) NSTimeInterval dateCreated;
@property (nonatomic, retain) CardioExercise *cardioExercise;
@property (nonatomic, retain) NSMutableArray *heavyWeightArray;
@property (nonatomic, retain) Measurements *measurements;
@property (nonatomic, retain) NSMutableArray *foodArray;
@property (nonatomic) double order;

@end