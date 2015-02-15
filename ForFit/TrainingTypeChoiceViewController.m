//
//  TrainingTypeChoiceViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 27.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import "TrainingTypeChoiceViewController.h"

@interface TrainingTypeChoiceViewController ()

@end

@implementation TrainingTypeChoiceViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (IBAction)showCardioWindow:(id)sender
{
    CardioDetailViewController *cardioWindowViewController = [[CardioDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    cardioWindowViewController.selectedCellIndexPath = self.selectedCellIndexPath;
    [self.navigationController pushViewController:cardioWindowViewController animated:YES];
}

- (IBAction)showWeightTrainingWindow:(id)sender
{
    HeavyWeightWindowViewController *heavyWeightWindowViewController = [[HeavyWeightWindowViewController alloc]initWithStyle:UITableViewStyleGrouped];
    heavyWeightWindowViewController.selectedCellIndexPath = self.selectedCellIndexPath;
    [self.navigationController pushViewController:heavyWeightWindowViewController animated:YES];
}

- (IBAction)showMeasurementsWindow:(id)sender
{
    MeasurementsWindowViewController *measurementsWindowViewController = [[MeasurementsWindowViewController alloc]initWithNibName:nil bundle:nil];
    measurementsWindowViewController.selectedCellIndexPath = self.selectedCellIndexPath;
    [self.navigationController pushViewController:measurementsWindowViewController animated:YES];
}

- (IBAction)showFoodWindow:(id)sender
{
    FoodWindowViewController *foodWindowViewController = [[FoodWindowViewController alloc]initWithStyle:UITableViewStyleGrouped];
    foodWindowViewController.selectedCellIndexPath = self.selectedCellIndexPath;
    [self.navigationController pushViewController:foodWindowViewController animated:YES];    
}

@end