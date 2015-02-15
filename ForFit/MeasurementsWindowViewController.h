//
//  MeasurementsWindowViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 04.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeasurementsFieldTableViewCell.h"
#import "Measurements.h"
#import "MeasurementsPhotoScrollViewController.h"
#import "AllInformationSharedStore.h"
#import "OneDayInformation.h"

@interface MeasurementsWindowViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath* indexPathForFieldCell;
@property (nonatomic, strong) Measurements *measurement;
@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

- (IBAction)takePhoto:(id)sender;

- (void)addMeasurement:(id)sender;

- (IBAction)showMeasurementsPhotoScrollViewController:(id)sender;

- (void)resignKeyboardAndEndEditing:(id)sender;

- (IBAction)deletePhoto:(id)sender;

@end