//
//  FoodWindowViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 27.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"
#import "FoodDetailWindowViewController.h"
#import "AllInformationSharedStore.h"
#import "OneDayInformation.h"

@interface FoodWindowViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *allMealsArray;
@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

- (int)totalAmountOfCalories;
- (void)showFoodDetailViewWindow:(id)sender;

@end