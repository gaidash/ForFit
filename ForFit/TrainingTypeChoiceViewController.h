//
//  TrainingTypeChoiceViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 27.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeavyWeightWindowViewController.h"
#import "CardioDetailViewController.h"
#import "MeasurementsWindowViewController.h"
#import "FoodWindowViewController.h"

@interface TrainingTypeChoiceViewController : UIViewController

@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

- (IBAction)showCardioWindow:(id)sender;
- (IBAction)showWeightTrainingWindow:(id)sender;
- (IBAction)showMeasurementsWindow:(id)sender;
- (IBAction)showFoodWindow:(id)sender;

@end