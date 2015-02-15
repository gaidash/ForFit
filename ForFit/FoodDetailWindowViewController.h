//
//  FoodDetailWindowViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 29.12.14.
//  Copyright (c) 2014 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@interface FoodDetailWindowViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    __weak IBOutlet UITextField *_nameField;
    __weak IBOutlet UITextField *_caloriesField;
    __weak IBOutlet UIImageView *_imageView;
}

@property (nonatomic, strong) Food *meal;
@property (nonatomic, strong) NSMutableArray *allMealsArray;

- (void)addNewMeal:(id)sender;

- (void)takePhoto:(id)sender;

- (void)deletePhoto:(id)sender;

@end