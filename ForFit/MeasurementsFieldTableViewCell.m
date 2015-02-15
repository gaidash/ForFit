//
//  MeasurementsFieldTableViewCell.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 05.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "MeasurementsFieldTableViewCell.h"

@implementation MeasurementsFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Getting width of the current device
        CGRect currentDeviceBounds = [[UIScreen mainScreen]bounds];
        CGFloat currentDeviceWidth = currentDeviceBounds.size.width;
        
        // Creating a field
        self.measurementsField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, currentDeviceWidth, self.frame.size.height)];
        self.measurementsField.textAlignment = NSTextAlignmentJustified;
        self.measurementsField.borderStyle = UITextBorderStyleBezel;
        self.measurementsField.font = [UIFont boldSystemFontOfSize:17];
        self.measurementsField.placeholder = @"Type (weight): measurement (kg) ";
        [self addSubview:self.measurementsField];
    }
    return  self;
}

@end