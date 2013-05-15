//
//  ImageViewController.h
//  SPoT
//
//  Created by Angel on 5/2/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface ImageViewController : UIViewController

@property (nonatomic, strong) Photo *photo;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)setPhoto:(Photo *)photo;
- (void)setImageURL:(NSURL *)imageURL;

@end
