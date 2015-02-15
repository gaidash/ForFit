//
//  MainWindowViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 06.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//  Singleton (MutableArray) [[AllInformationSharedStore sharedStore]allInformationArray]

#import "MainWindowViewController.h"

// CARDIO - CardioExercise *
#define CARDIO [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:indexPath.row]cardioExercise]

// HEAVYWEIGHT - NSMutableArray *
#define HEAVYWEIGHT [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:indexPath.row]heavyWeightArray]

// MEASUREMENTS - Measurements *
#define MEASUREMENTS [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:indexPath.row]measurements]
// FOOD - NSMutableArray *
#define FOOD [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:indexPath.row]foodArray]

@interface MainWindowViewController ()

@end

@implementation MainWindowViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"For Fit";
        [self.navigationItem setRightBarButtonItem:self.editButtonItem animated:YES];
        
        UIBarButtonItem *addTrainingButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTraining:)];
        [self.navigationItem setLeftBarButtonItem:addTrainingButton];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Loading nib-file
    UINib *nib = [UINib nibWithNibName:@"MainWindowTableViewCell" bundle:nil];
    // Registering nib-file
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MainWindowTableViewCell"];
}


# pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainWindowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainWindowTableViewCell"];
    
    // Writing a date on a cell's label
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat =@"yyyy, MMM d, EEE";
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[[[[AllInformationSharedStore sharedStore]allInformationArray] objectAtIndex:indexPath.row] dateCreated]];
    [cell.dateLabel setText:[dateFormatter stringFromDate:date]];
    
    // Creating actions for cells
    [cell.cardioButton addTarget:self action:@selector(showCardioWindowFromIcon:) forControlEvents:UIControlEventTouchUpInside];
    [cell.weightButton addTarget:self action:@selector(showWeightTrainingWindowFromIcon:) forControlEvents:UIControlEventTouchUpInside];
    [cell.measurementsButton addTarget:self action:@selector(showMeasurementsWindowFromIcon:) forControlEvents:UIControlEventTouchUpInside];
    [cell.foodButton addTarget:self action:@selector(showFoodWindowFromIcon:) forControlEvents:UIControlEventTouchUpInside];
    
    // Making buttons on cells visible if there is some information
    // Checking the conditions for the cardio button to appear or not
    if (CARDIO == nil ||
        
        // Text field for exercise type
        (([CARDIO exerciseType] == nil || [[CARDIO exerciseType] isEqualToString: @""]) &&
         
         // Text field for distance
         ([CARDIO distance] == nil || [[CARDIO distance] isEqualToString: @""]) &&
         
         // Text field for time
         ([CARDIO time] == nil || [[CARDIO time] isEqualToString: @""]) &&
         
         // Text field for burned calories
         ([CARDIO caloriesBurned] == nil || [[CARDIO caloriesBurned] isEqualToString: @""]))
        ) {
        cell.cardioButton.hidden = YES;
    } else {
        cell.cardioButton.hidden = NO;
    }
    
    // Weight training
    if ([HEAVYWEIGHT count] > 0) {
        cell.weightButton.hidden = NO;
    } else {
        cell.weightButton.hidden = YES;
    }
    
    
    // Measurements
    // Creating a temporary string and add all the strings from text fields (if there is no information, the temporary string will be empty)
    NSString *temporaryString = @"";
    if (MEASUREMENTS != nil) {
        for (NSString *string in [MEASUREMENTS measurementsArray]) {
            temporaryString = [temporaryString stringByAppendingString:string];
        }
    }

    // Checking out if the measuments button should appear or not
    if (MEASUREMENTS == nil ||
        
        // Checking measurement.photo and measurementsArray
        ([MEASUREMENTS imageNameString] == nil &&
         
         ([MEASUREMENTS measurementsArray] == nil ||
          
          [temporaryString isEqualToString:@""]))
    
    ){
        cell.measurementsButton.hidden = YES;
    } else {
        cell.measurementsButton.hidden = NO;
    }
    
    // Food
    if ([FOOD count] > 0) {
        cell.foodButton.hidden = NO;
    } else {
        cell.foodButton.hidden = YES;
    }
    
    
    // Highlighting a cell with a today's date (if there is one)
    if ([cell.dateLabel.text isEqualToString:[dateFormatter stringFromDate:[NSDate date]]]) {
        cell.dateLabel.font = [UIFont boldSystemFontOfSize:17.0];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AllInformationSharedStore sharedStore]allInformationArray] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[[AllInformationSharedStore sharedStore]managedContext]deleteObject:[[[AllInformationSharedStore sharedStore]allInformationArray] objectAtIndex:indexPath.row]];
        [[[AllInformationSharedStore sharedStore]allInformationArray] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Your training days";
}


# pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainingTypeChoiceViewController *trainingTypeChoiceViewController = [[TrainingTypeChoiceViewController alloc]initWithNibName:nil bundle:nil];
    trainingTypeChoiceViewController.selectedCellIndexPath = indexPath;
    [self.navigationController pushViewController:trainingTypeChoiceViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}


#pragma mark - My methods
- (void)addTraining:(id)sender
{
    OneDayInformation *oneDayInformation = [NSEntityDescription insertNewObjectForEntityForName:@"OneDayInformation" inManagedObjectContext:[[AllInformationSharedStore sharedStore]managedContext]];
    
    // Creating a date
    NSDate *date = [NSDate date];
    oneDayInformation.dateCreated = [date timeIntervalSinceReferenceDate];
    
    // If there is already a training created for this date, show an alert
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    // Looking for the same date
    for (OneDayInformation *information in [[AllInformationSharedStore sharedStore]allInformationArray]) {
        
        NSString *temporaryDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:information.dateCreated]];
        if ([dateString isEqualToString:temporaryDateString]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning!" message:@"You have already created a training for today, use it!" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:NULL];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
            [alert addAction:okAction];
            
            // Deleting an entity
            [[[AllInformationSharedStore sharedStore]managedContext]deleteObject:oneDayInformation];
            oneDayInformation = nil;
            
            break;
        }
    }
    
    // If there is no training for this day, create it (entity)
    if (oneDayInformation) {
        // Setting an order
        double order;
        if ([[[AllInformationSharedStore sharedStore]allInformationArray]count] == 0) {
            order = 1.0;
        } else {
            order = [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:0]order] + 1.0;
        }
        oneDayInformation.order = order;
        
        // Inserting a created object in the beginning
        [[[AllInformationSharedStore sharedStore]allInformationArray] insertObject:oneDayInformation atIndex:0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)showCardioWindowFromIcon:(id)sender
{
    CardioDetailViewController *cardioWindowViewController = [[CardioDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    // Getting current index path and sending it to the next window
    UIButton *button = (UIButton *) sender;
    UIView *contentView = (UIView *) button.superview;
    MainWindowTableViewCell *cell = (MainWindowTableViewCell *) contentView.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    cardioWindowViewController.selectedCellIndexPath = indexPath;
    
    [self.navigationController pushViewController:cardioWindowViewController animated:YES];
}

- (void)showWeightTrainingWindowFromIcon:(id)sender
{
    HeavyWeightWindowViewController *heavyWeightWindowViewController = [[HeavyWeightWindowViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    // Getting current index path and sending it to the next window
    UIButton *button = (UIButton *) sender;
    UIView *contentView = (UIView *) button.superview;
    MainWindowTableViewCell *cell = (MainWindowTableViewCell *) contentView.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    heavyWeightWindowViewController.selectedCellIndexPath = indexPath;
    
    [self.navigationController pushViewController:heavyWeightWindowViewController animated:YES];
}

- (void)showMeasurementsWindowFromIcon:(id)sender
{
    MeasurementsWindowViewController *measurementsWindowViewController = [[MeasurementsWindowViewController alloc]initWithNibName:nil bundle:nil];
    
    // Getting current index path and sending it to the next window
    UIButton *button = (UIButton *) sender;
    UIView *contentView = (UIView *) button.superview;
    MainWindowTableViewCell *cell = (MainWindowTableViewCell *) contentView.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    measurementsWindowViewController.selectedCellIndexPath = indexPath;
    
    [self.navigationController pushViewController:measurementsWindowViewController animated:YES];
}

- (void)showFoodWindowFromIcon:(id)sender
{
    FoodWindowViewController *foodWindowViewController = [[FoodWindowViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    // Getting current index path and sending it to the next window
    UIButton *button = (UIButton *) sender;
    UIView *contentView = (UIView *) button.superview;
    MainWindowTableViewCell *cell = (MainWindowTableViewCell *) contentView.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    foodWindowViewController.selectedCellIndexPath = indexPath;
    
    [self.navigationController pushViewController:foodWindowViewController animated:YES];
}

@end