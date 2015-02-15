//
//  NoteFieldTableViewCell.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 02.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "NoteFieldTableViewCell.h"

@implementation NoteFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    self.noteField = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44.0 * 3)];
    self.noteField.font = [UIFont boldSystemFontOfSize:17];
    self.noteField.textAlignment = NSTextAlignmentNatural;
    [self addSubview:self.noteField];
    }
    return  self;
}

@end