//
//  MeasurementsPhotoScrollViewController.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 05.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "MeasurementsPhotoScrollViewController.h"

@interface MeasurementsPhotoScrollViewController ()

@end

@implementation MeasurementsPhotoScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.navigationItem.title = @"Your measurements photo";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.imageView setImage:self.image];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end