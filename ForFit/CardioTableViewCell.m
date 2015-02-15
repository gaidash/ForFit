//
//  CardioTableViewCell.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 04.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "CardioTableViewCell.h"

@implementation CardioTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Getting cell height and width
        CGRect currentIphoneBounds = [[UIScreen mainScreen]bounds];
        CGFloat cellHeight = self.frame.size.height;
        CGFloat cellWidth = currentIphoneBounds.size.width;
        
        // Setting a label in the left part of the cell
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cellWidth / 4.2, cellHeight)];
        self.label.font = [UIFont boldSystemFontOfSize:17];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        // Setting the text field after the label
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(cellWidth / 4.2, 0, cellWidth - self.label.frame.size.width, cellHeight)];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.borderStyle = UITextBorderStyleBezel;
        self.textField.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:self.textField];
    }
    return self;
}

@end