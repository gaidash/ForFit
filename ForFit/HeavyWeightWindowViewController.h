//
//  HeavyWeightWindowViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 27.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeavyWeightExercise.h"
#import "HeavyWeightDetailWindowViewController.h"
#import "AllInformationSharedStore.h"
#import "OneDayInformation.h"

@interface HeavyWeightWindowViewController : UITableViewController

@property (nonatomic) NSMutableArray *exercisesArray;
@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

- (void)addExercise:(id)sender;

@end