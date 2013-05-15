//
//  PhotosByTagViewController.h
//  CoreDataSPoT
//
//  Created by Angel on 5/13/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Tag.h"

@interface PhotosByTagViewController : CoreDataTableViewController

@property (nonatomic, strong) Tag *tag;

@end
