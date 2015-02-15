//
//  NameFieldTableViewCell.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 02.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "NameFieldTableViewCell.h"

@implementation NameFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Getting width of the current device
        CGRect currentDeviceBounds = [[UIScreen mainScreen]bounds];
        CGFloat currentDeviceWidth = currentDeviceBounds.size.width;
        
        // Creating a field
        self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, currentDeviceWidth, self.frame.size.height)];
        self.nameField.textAlignment = NSTextAlignmentCenter;
        self.nameField.borderStyle = UITextBorderStyleBezel;
        self.nameField.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:self.nameField];
    }
    return  self;
}

@end