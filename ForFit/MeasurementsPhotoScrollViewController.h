//
//  MeasurementsPhotoScrollViewController.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 05.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasurementsPhotoScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end