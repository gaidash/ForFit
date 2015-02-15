//
//  HeavyWeightDetailWindowViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 01.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "HeavyWeightDetailWindowViewController.h"

@interface HeavyWeightDetailWindowViewController ()

@end

@implementation HeavyWeightDetailWindowViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *deleteLastSetButton = [[UIBarButtonItem alloc]initWithTitle:@"Delete last set" style:UIBarButtonItemStyleDone target:self action:@selector(deleteLastSet:)];
        [self.navigationItem setRightBarButtonItem:deleteLastSetButton animated:YES];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        // Creating a tap gesture recognizer
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard:)];
        [self.tableView addGestureRecognizer:tapGestureRecognizer];
        
        // Registering cells
        [self.tableView registerClass:[NameFieldTableViewCell class] forCellReuseIdentifier:@"NameFieldTableViewCell"];
        [self.tableView registerClass:[NoteFieldTableViewCell class] forCellReuseIdentifier:@"NoteFieldTableViewCell"];
        [self.tableView registerClass:[WeightRepsTableViewCell class] forCellReuseIdentifier:@"WeightRepsTableViewCell"];
    }
    return self;
}


# pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NameFieldTableViewCell *cell = (NameFieldTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"NameFieldTableViewCell"];
        [cell.nameField setDelegate:self];
        cell.nameField.text = self.selectedExercise.name;
        return cell;
    } else if (indexPath.section == 2) {
        NoteFieldTableViewCell *cell = (NoteFieldTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"NoteFieldTableViewCell"];
        [cell.noteField setDelegate:self];
        [cell.noteField setText:self.selectedExercise.note];
        return cell;
    } else if (indexPath.section == 1) {
        WeightRepsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeightRepsTableViewCell"];
        [cell.weightRepsField setDelegate:self];
        cell.weightRepsField.text = [self.selectedExercise.weightsRepsArray objectAtIndex:indexPath.row];
        cell.setLabel.text = [NSString stringWithFormat:@"Set %lu.", (unsigned long) indexPath.row + 1];
        [self makeDeleteLastSetButtonEnabledOrDisabled];
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.selectedExercise.weightsRepsArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"The name of the exercise";
    } else if (section == 2) {
        return @"Write your note here";
    } else {
        return @"Enter weight and repetitions";
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

# pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIButton *addSetButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height / 15)];
        [addSetButton setTitle:@"Add a set" forState:UIControlStateNormal];
        [addSetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addSetButton setBackgroundColor:[UIColor blueColor]];
        [addSetButton addTarget:self action:@selector(addSet:) forControlEvents:UIControlEventTouchUpInside];
        return addSetButton;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [[UIScreen mainScreen]bounds].size.height / 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 44.0 * 3;
    } else {
        return 44.0;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITableViewCell *cell = (UITableViewCell *) textField.superview;
    self.indexPathForFieldCell = [self.tableView indexPathForCell:cell];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.indexPathForFieldCell.section == 1) {
        [self.selectedExercise.weightsRepsArray removeObjectAtIndex:self.indexPathForFieldCell.row];
        [self.selectedExercise.weightsRepsArray insertObject:textField.text atIndex:self.indexPathForFieldCell.row];
    } else if (self.indexPathForFieldCell.section == 0) {
        self.selectedExercise.name = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.selectedExercise.note = textView.text;
}

#pragma mark - My methods
- (void)addSet:(id)sender
{
    UIButton *button = (UIButton *) sender;
    [UIView animateWithDuration:0.3 animations:^{button.backgroundColor = [UIColor grayColor]; button.backgroundColor = [UIColor blueColor];} completion:NULL];
    NSString *nullString = [[NSString alloc]init];
    if (!self.selectedExercise.weightsRepsArray) {
        self.selectedExercise.weightsRepsArray = [[NSMutableArray alloc]initWithObjects:nullString, nil];
    } else {
        [self.selectedExercise.weightsRepsArray addObject:nullString];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self makeDeleteLastSetButtonEnabledOrDisabled];
}

- (void)resignKeyboard:(id)sender
{
    [self.tableView endEditing:YES];
    [self.tableView reloadData];
    [self makeDeleteLastSetButtonEnabledOrDisabled];
}

- (void)deleteLastSet:(id)sender
{
    [self.tableView endEditing:YES];
    [self.selectedExercise.weightsRepsArray removeLastObject];
    [self.tableView reloadData];
    [self makeDeleteLastSetButtonEnabledOrDisabled];
}

- (void)makeDeleteLastSetButtonEnabledOrDisabled
{
    if (self.selectedExercise.weightsRepsArray.count != 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

@end