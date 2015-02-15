//
//  MainWindowViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 06.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainWindowTableViewCell.h"
#import "TrainingTypeChoiceViewController.h"
#import "AllInformationSharedStore.h"
#import "OneDayInformation.h"


@interface MainWindowViewController : UITableViewController

- (void)addTraining:(id)sender;

- (void)showCardioWindowFromIcon:(id)sender;
- (void)showWeightTrainingWindowFromIcon:(id)sender;
- (void)showMeasurementsWindowFromIcon:(id)sender;
- (void)showFoodWindowFromIcon:(id)sender;

@end