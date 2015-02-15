//
//  WeightRepsTableViewCell.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 03.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "WeightRepsTableViewCell.h"

@implementation WeightRepsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Getting cell height and width
        CGRect currentIphoneBounds = [[UIScreen mainScreen]bounds];
        CGFloat cellHeight = self.frame.size.height;
        CGFloat cellWidth = currentIphoneBounds.size.width;
        
        
        // Setting a label in the left part of the cell
        self.setLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cellWidth / 5, cellHeight)];
        self.setLabel.font = [UIFont boldSystemFontOfSize:17];
        self.setLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.setLabel];
        
        // Setting the text field after the label
        self.weightRepsField = [[UITextField alloc]initWithFrame:CGRectMake(cellWidth / 5, 0, cellWidth - self.setLabel.frame.size.width, cellHeight)];
        self.weightRepsField.textAlignment = NSTextAlignmentCenter;
        self.weightRepsField.borderStyle = UITextBorderStyleBezel;
        self.weightRepsField.font = [UIFont boldSystemFontOfSize:17];
        self.weightRepsField.placeholder = @"Weight (kg) x repetitions";
        [self addSubview:self.weightRepsField];
    }
    return self;
}

@end