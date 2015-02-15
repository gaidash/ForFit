//
//  FoodWindowViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 27.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import "FoodWindowViewController.h"

@interface FoodWindowViewController ()

@end

@implementation FoodWindowViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Your meals";
        [self.navigationItem setRightBarButtonItem:self.editButtonItem animated:YES];
        
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
    
    // Checking out if the array with the food is created
    if ([[[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]foodArray]count] == 0) {
        self.allMealsArray = [[NSMutableArray alloc]init];
    } else {
        self.allMealsArray = [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]foodArray];
        if (self.allMealsArray.count > 0) {
            NSArray *temporaryArray = [self.allMealsArray copy];
            for (Food *food in temporaryArray) {
                if ([food.name isEqualToString:@""] && food.calories == 0 && food.imageNameString == nil) {
                    [self.allMealsArray removeObject:food];
                }
            }
        }
    }

    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    OneDayInformation *oneDayInformation = [[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row];
    oneDayInformation.foodArray = self.allMealsArray;
}


# pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    Food *meal = [self.allMealsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:meal.name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%u calories", meal.calories]];
    
    // Setting an image
    // Getting a document directory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    // Getting an image data
    NSData *imageData = [NSData dataWithContentsOfFile:[documentDirectory stringByAppendingPathComponent:meal.imageNameString]];
    [cell.imageView setImage:[UIImage imageWithData:imageData]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allMealsArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Total amount of calories: %u", [self totalAmountOfCalories]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.allMealsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}

# pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailWindowViewController *foodDetailViewController = [[FoodDetailWindowViewController alloc]initWithNibName:nil bundle:nil];
    foodDetailViewController.meal = [self.allMealsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:foodDetailViewController animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *addMealButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height / 15)];
    [addMealButton setTitle:@"Add a meal" forState:UIControlStateNormal];
    [addMealButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addMealButton setBackgroundColor:[UIColor blueColor]];
    [addMealButton addTarget:self action:@selector(showFoodDetailViewWindow:) forControlEvents:UIControlEventTouchUpInside];
    
    return addMealButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [[UIScreen mainScreen]bounds].size.height / 15;
}


# pragma mark - My methods
- (int)totalAmountOfCalories
{
    int amount = 0;
    for (Food *meal in self.allMealsArray) {
        amount = amount + meal.calories;
    }
    return amount;
}

- (void)showFoodDetailViewWindow:(id)sender
{
    UIButton *button = (UIButton *) sender;
    [UIView animateWithDuration:0.3 animations:^{button.alpha = 0.5; button.alpha = 1.0;} completion:NULL];
    FoodDetailWindowViewController *foodDetailWindowViewController = [[FoodDetailWindowViewController alloc]initWithNibName:nil bundle:nil];
    foodDetailWindowViewController.allMealsArray = self.allMealsArray;
    foodDetailWindowViewController.meal = [[Food alloc]init];
    [self.navigationController pushViewController:foodDetailWindowViewController animated:YES];
}

@end