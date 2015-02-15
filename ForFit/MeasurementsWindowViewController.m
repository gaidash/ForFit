//
//  MeasurementsWindowViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 04.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "MeasurementsWindowViewController.h"

@interface MeasurementsWindowViewController ()

@end

@implementation MeasurementsWindowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.navigationItem.title = @"Enter measurements";
        
        UIBarButtonItem *endTypingButton = [[UIBarButtonItem alloc]initWithTitle:@"End typing" style:UIBarButtonItemStylePlain target:self action:@selector(resignKeyboardAndEndEditing:)];
        [self.navigationItem setRightBarButtonItem:endTypingButton];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
        
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
    if ([[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]measurements] == nil) {
        self.measurement = [[Measurements alloc]init];
    } else {
        self.measurement = [[[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row]measurements];
    }

    // If there is a saved image, use it
    if (self.measurement.imageNameString) {
        // Getting a document directory
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [documentDirectories objectAtIndex:0];
        // Getting an image data
        NSData *imageData = [NSData dataWithContentsOfFile:[documentDirectory stringByAppendingPathComponent:self.measurement.imageNameString]];
        
        // Making an image to appear
        self.imageView.image = [UIImage imageWithData:imageData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    if (self.measurement.measurementsArray.count > 0) {
        NSArray *temporaryArray = [self.measurement.measurementsArray copy];
        for (NSString *string in temporaryArray) {
            if ([string isEqualToString:@""]) {
                [self.measurement.measurementsArray removeObject:string];
            }
        }
    }
    
    OneDayInformation *oneDayInformation = [[[AllInformationSharedStore sharedStore]allInformationArray]objectAtIndex:self.selectedCellIndexPath.row];
    oneDayInformation.measurements = self.measurement;
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Creating UUID
    CFUUIDRef uniqueID = CFUUIDCreate(kCFAllocatorDefault);
    // Creating an imageNameString (NSString *) based on UUID
    CFStringRef uniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, uniqueID);
    self.measurement.imageNameString = (__bridge NSString *)uniqueIDString;
    // Releasing unnecessary objects
    CFRelease(uniqueID);
    CFRelease(uniqueIDString);
    
    
    // Storing an image in library
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    
    // Creating and compressing the image data
    NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.0);
    // Saving the image data to a library directory with a unique name
    [imageData writeToFile:[documentDirectory stringByAppendingPathComponent:self.measurement.imageNameString] atomically:YES];
    
    [_imageView setImage:[UIImage imageWithData:imageData]];
    [self dismissViewControllerAnimated:YES completion:nil];

}

# pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeasurementsFieldTableViewCell *cell = (MeasurementsFieldTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MeasurementsFieldTableViewCell"];
    if (!cell) {
        cell = [[MeasurementsFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeasurementsFieldTableViewCell"];
    }
    [cell.measurementsField setDelegate:self];
    cell.measurementsField.text = [self.measurement.measurementsArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.measurement.measurementsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.measurement.measurementsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }
}


# pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *addMeasurementButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,[[UIScreen mainScreen]bounds].size.height / 15)];
    [addMeasurementButton setTitle:@"Add your measurement" forState:UIControlStateNormal];
    [addMeasurementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addMeasurementButton setBackgroundColor:[UIColor blueColor]];
    [addMeasurementButton addTarget:self action:@selector(addMeasurement:) forControlEvents:UIControlEventTouchUpInside];
    return addMeasurementButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [[UIScreen mainScreen]bounds].size.height / 15;
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
    [self.measurement.measurementsArray removeObjectAtIndex:self.indexPathForFieldCell.row];
    [self.measurement.measurementsArray insertObject:textField.text atIndex:self.indexPathForFieldCell.row];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - My methods
- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    [imagePickerController setDelegate:self];
    
    // Adding a window to choose between camera and photo library
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Choose a source of a picture" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    // Camera
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    } [self presentViewController:imagePickerController animated:YES completion:nil];}];
    [alert addAction:cameraAction];
    
    // Photo Library
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                         { [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary]; [self presentViewController:imagePickerController animated:YES completion:nil];}];
    [alert addAction:photoLibraryAction];
    
    // Cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
    [alert addAction:cancelAction];
}

- (void)addMeasurement:(id)sender
{
    UIButton *button = (UIButton *) sender;
    [UIView animateWithDuration:0.3 animations:^{button.backgroundColor = [UIColor grayColor]; button.backgroundColor = [UIColor blueColor];} completion:NULL];
    NSString *nullString = [[NSString alloc]init];
    if (!self.measurement.measurementsArray) {
        self.measurement.measurementsArray = [[NSMutableArray alloc]initWithObjects:nullString, nil];
    } else {
        [self.measurement.measurementsArray addObject:nullString];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)showMeasurementsPhotoScrollViewController:(id)sender
{
    // Don't open MeasurementsPhotoScrollViewController if there is no photo
    if (self.measurement.imageNameString == nil) {
        return;
    }
    // Making animation
    [UIView animateWithDuration:1.0 animations:^{self.imageView.alpha = 0.5; self.imageView.alpha = 1.0;} completion:NULL];
    
    MeasurementsPhotoScrollViewController *measurementsPhotoScrollViewController = [[MeasurementsPhotoScrollViewController alloc]initWithNibName:nil bundle:nil];
    
    
    // Getting a document directory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    // Getting an image data
    NSData *imageData = [NSData dataWithContentsOfFile:[documentDirectory stringByAppendingPathComponent:self.measurement.imageNameString]];
    
    // Making an image to appear
    measurementsPhotoScrollViewController.image = [UIImage imageWithData:imageData];
    
    
    [self.navigationController pushViewController:measurementsPhotoScrollViewController animated:YES];
}

- (void)resignKeyboardAndEndEditing:(id)sender
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.view endEditing:YES];
}

- (IBAction)deletePhoto:(id)sender
{
    self.imageView.image = nil;
    self.measurement.imageNameString = nil;
    [self.view setNeedsDisplay];
}

@end