//
//  Food.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 28.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Food : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic) int calories;
@property (nonatomic, copy) NSString *imageNameString;

@end