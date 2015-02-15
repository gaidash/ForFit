//
//  MainWindowTableViewCell.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 07.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainWindowTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *cardioButton;
@property (weak, nonatomic) IBOutlet UIButton *weightButton;
@property (weak, nonatomic) IBOutlet UIButton *measurementsButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;

@end