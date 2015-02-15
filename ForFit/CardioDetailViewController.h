//
//  CardioDetailViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 04.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardioExercise.h"
#import "CardioTableViewCell.h"
#import "AllInformationSharedStore.h"
#import "OneDayInformation.h"

@interface CardioDetailViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) CardioExercise *cardioExercise;
@property (nonatomic, strong) NSIndexPath *indexPathForFieldCell;

// For saving
@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

- (void)resignKeyboard:(id)sender;

@end