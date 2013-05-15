//
//  RecentsViewController.h
//  CoreDataSPoT
//
//  Created by Angel on 5/14/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Photo.h"

@interface RecentsViewController : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
