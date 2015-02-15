//
//  HeavyWeightWindowViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 27.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import "HeavyWeightWindowViewController.h"

@interface HeavyWeightWindowViewController ()

@end

@implementation HeavyWeightWindowViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Add your exercise";
        [self.navigationItem setRightBarButtonItem:self.editButtonItem animated:YES];
        // Creating a back button for the next ViewController
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backButton];
        
        
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
    
    // Checking out if the array with the heavy weight exercises is created
    if ([[[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]heavyWeightArray]count] == 0) {
        self.exercisesArray = [[NSMutableArray alloc]init];
    } else {
        self.exercisesArray = [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]heavyWeightArray];
    }
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    OneDayInformation *oneDayInformation = [[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row];
    oneDayInformation.heavyWeightArray = self.exercisesArray;
}


# pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    HeavyWeightExercise *exercise = [self.exercisesArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%lu. %@", (unsigned long) indexPath.row + 1, exercise.name]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.exercisesArray count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.exercisesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

# pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeavyWeightDetailWindowViewController *heavyWeightDetailWindowViewController = [[HeavyWeightDetailWindowViewController alloc]initWithStyle:UITableViewStyleGrouped];
    heavyWeightDetailWindowViewController.selectedExercise = [self.exercisesArray objectAtIndex:indexPath.row];
    
    // For core data to get a managed object
    heavyWeightDetailWindowViewController.selectedCellIndexPath = self.selectedCellIndexPath;
    
    // Setting a navigationItem.title for the heavyWeightDetailWindowViewController
    heavyWeightDetailWindowViewController.navigationItem.title = @"Edit your exercise";
    
    [self.navigationController pushViewController:heavyWeightDetailWindowViewController animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *addExerciseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height / 15)];
    [addExerciseButton setTitle:@"Add an exercise" forState:UIControlStateNormal];
    [addExerciseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addExerciseButton setBackgroundColor:[UIColor blueColor]];
    [addExerciseButton addTarget:self action:@selector(addExercise:) forControlEvents:UIControlEventTouchUpInside];
    
    return addExerciseButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [[UIScreen mainScreen]bounds].size.height / 15;
}

#pragma mark - My methods
- (void)addExercise:(id)sender
{
    UIButton *button = (UIButton *) sender;
    [UIView animateWithDuration:0.3 animations:^{button.alpha = 0.5; button.alpha = 1.0;} completion:NULL];
    
    // Creating a UIAlertViewController with two actions (ok and cancel)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter a name of an exercise" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {}];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *textFieldString = [NSString stringWithFormat:@"%@", alert.textFields[0]];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"'"];
        NSArray *stringsArray = [textFieldString componentsSeparatedByCharactersInSet:characterSet];
        HeavyWeightExercise *exercise = [[HeavyWeightExercise alloc]init];
        exercise.name = stringsArray[1];
        [self.exercisesArray addObject:exercise];
        [self.tableView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end