//
//  HeavyWeightDetailWindowViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 01.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeavyWeightWindowViewController.h"
#import "NameFieldTableViewCell.h"
#import "NoteFieldTableViewCell.h"
#import "WeightRepsTableViewCell.h"

@interface HeavyWeightDetailWindowViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) HeavyWeightExercise *selectedExercise;
@property (nonatomic, strong) NSIndexPath *indexPathForFieldCell;
@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

- (void)addSet:(id)sender;

- (void)resignKeyboard:(id)sender;

- (void)deleteLastSet:(id)sender;

- (void)makeDeleteLastSetButtonEnabledOrDisabled;

@end