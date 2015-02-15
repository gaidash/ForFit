//
//  Measurements.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 05.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Measurements : NSObject <NSCoding>

@property (nonatomic, copy) NSString *imageNameString;
@property (nonatomic, strong) NSMutableArray *measurementsArray;

@end