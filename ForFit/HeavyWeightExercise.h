//
//  HeavyWeightExercise.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 01.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeavyWeightExercise : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *note;

@property (nonatomic, strong) NSMutableArray *weightsRepsArray;

@end