//
//  CardioDetailViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 04.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "CardioDetailViewController.h"

@interface CardioDetailViewController ()

@end

@implementation CardioDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Cardio";
        
        UIBarButtonItem *endTypingButton = [[UIBarButtonItem alloc]initWithTitle:@"End typing" style:UIBarButtonItemStylePlain target:self action:@selector(resignKeyboard:)];
        [self.navigationItem setRightBarButtonItem:endTypingButton];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        // Creating a tap gesture recognizer
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard:)];
        [self.tableView addGestureRecognizer:tapGestureRecognizer];
        
        // Registering cells
        [self.tableView registerClass:[CardioTableViewCell class] forCellReuseIdentifier:@"CardioTableViewCell"];
        
        // For core data
        // Creating  and executing a fetch request
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"OneDayInformation"];
        NSError *error = nil;
        if (![[[AllInformationSharedStore sharedStore]managedContext] executeFetchRequest:fetchRequest error:&error]
            ) {
            [NSException raise:@"Could not execute a fetch request" format:@"Reason: %@", error.localizedDescription];
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Checking out if the array with the cardio exercise is created
    if ([[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]cardioExercise] == nil) {
        self.cardioExercise = [[CardioExercise alloc]init];
    } else {
        self.cardioExercise = [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]cardioExercise];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    OneDayInformation *oneDayInformation = [[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row];
    oneDayInformation.cardioExercise = self.cardioExercise;
}


# pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardioTableViewCell *cell = (CardioTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"CardioTableViewCell"];
    [cell.textField setDelegate:self];
    if (indexPath.row == 0) {
        cell.label.text = @"Exercise";
        if (self.cardioExercise.exerciseType == nil || [self.cardioExercise.exerciseType isEqualToString:@""]) {
            cell.textField.placeholder = @"Type of an exercise...";
        } else {
            cell.textField.text = self.cardioExercise.exerciseType;
        
        }
    } else if (indexPath.row == 1) {
        cell.label.text = @"Distance";
        if (self.cardioExercise.distance == nil || [self.cardioExercise.distance isEqualToString:@""]) {
            cell.textField.placeholder = @"Total distance run...";
        } else {
            cell.textField.text = self.cardioExercise.distance;
        }
    } else if (indexPath.row == 2) {
        cell.label.text = @"Time";
        if (self.cardioExercise.time == nil || [self.cardioExercise.time isEqualToString:@""]) {
            cell.textField.placeholder = @"Elapsed time...";
        } else {
            cell.textField.text = self.cardioExercise.time;
        }
    } else {
        cell.label.text = @"Calories";
        if (self.cardioExercise.caloriesBurned == nil || [self.cardioExercise.caloriesBurned isEqualToString:@""]) {
            cell.textField.placeholder = @"Burned calories...";
        } else {
            cell.textField.text = self.cardioExercise.caloriesBurned;
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Enter type of cardio, distance, time and amount of burned calories";

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    UITableViewCell *cell = (UITableViewCell *) textField.superview;
    self.indexPathForFieldCell = [self.tableView indexPathForCell:cell];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.indexPathForFieldCell.row == 0) {
        self.cardioExercise.exerciseType = textField.text;
    } else if (self.indexPathForFieldCell.row == 1) {
        self.cardioExercise.distance = textField.text;
    } else if (self.indexPathForFieldCell.row == 2) {
        self.cardioExercise.time = textField.text;
    } else {
        self.cardioExercise.caloriesBurned = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - My methods
- (void)resignKeyboard:(id)sender
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.tableView endEditing:YES];
    [self.tableView reloadData];
}

@end