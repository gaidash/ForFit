//
//  FoodDetailWindowViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 29.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import "FoodDetailWindowViewController.h"

@interface FoodDetailWindowViewController ()

@end

@implementation FoodDetailWindowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.navigationItem.title = @"Add your meal";
        // Create a button to take a photo
        UIBarButtonItem *takePhotoButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto:)];
        
        // Create a button to delete a photo
        UIBarButtonItem *deletePhotoButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deletePhoto:)];
        
        // Adding buttons to a navigation item
        [self.navigationItem setRightBarButtonItems:@[deletePhotoButton, takePhotoButton] animated:YES];
        
        // Hide the system back bar button
        self.navigationItem.hidesBackButton = YES;
        // Create a new back bar button
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(addNewMeal:)];
        [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _nameField.text = self.meal.name;
    _caloriesField.text = [NSString stringWithFormat:@"%u", self.meal.calories];
    
    // If there is a saved image, use it
    if (self.meal.imageNameString) {
        // Getting a document directory
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [documentDirectories objectAtIndex:0];
        // Getting an image data
        NSData *imageData = [NSData dataWithContentsOfFile:[documentDirectory stringByAppendingPathComponent:self.meal.imageNameString]];
        
        // Making an image to appear
        _imageView.image = [UIImage imageWithData:imageData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
        
    self.meal.name = _nameField.text;
    self.meal.calories = [_caloriesField.text intValue];
    
    // Saving changes to core data if the user closes the application
    if (self.presentedViewController == nil) {
        if ([_nameField.text  isEqual: @""] && ([_caloriesField.text  isEqualToString: @"0"] || [_caloriesField.text  isEqualToString:@""]) && self.meal.imageNameString == nil) {
            return;
        } else {
            Food *newMeal = [[Food alloc]init];
            newMeal.name = _nameField.text;
            newMeal.calories = [_caloriesField.text intValue];
            newMeal.imageNameString = self.meal.imageNameString;
            [self.allMealsArray addObject:newMeal];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Creating UUID
    CFUUIDRef uniqueID = CFUUIDCreate(kCFAllocatorDefault);
    // Creating an imageNameString (NSString *) based on UUID
    CFStringRef uniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, uniqueID);
    self.meal.imageNameString = (__bridge NSString *)uniqueIDString;
    // Releasing unnecessary objects
    CFRelease(uniqueID);
    CFRelease(uniqueIDString);
    
    
    // Storing an image in library
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    
    // Creating and compressing the image data
    NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.0);
    // Saving the image data to a library directory with a unique name
    [imageData writeToFile:[documentDirectory stringByAppendingPathComponent:self.meal.imageNameString] atomically:YES];
    
    [_imageView setImage:[UIImage imageWithData:imageData]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - My methods
- (void)addNewMeal:(id)sender
{
    if ([_nameField.text  isEqual: @""] && ([_caloriesField.text  isEqual: @"0"] || [_caloriesField.text  isEqual: @""]) && _imageView.image == nil) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        Food *newMeal = [[Food alloc]init];
        newMeal.name = _nameField.text;
        newMeal.calories = [_caloriesField.text intValue];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)takePhoto:(id)sender {
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

- (void)deletePhoto:(id)sender
{
    _imageView.image = nil;
    self.meal.imageNameString = nil;
    [self.view setNeedsDisplay];
}

@end