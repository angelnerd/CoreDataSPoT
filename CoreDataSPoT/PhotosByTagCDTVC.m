//
//  PhotosByTagCDTVC.m
//  CoreDataSPoT
//
//  Created by Angel on 5/15/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "PhotosByTagCDTVC.h"

@interface PhotosByTagCDTVC ()

@end

@implementation PhotosByTagCDTVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setTag:(Tag *)tag
{
    _tag = tag;
    self.title = tag.tagName;
    [self setupFetchedResultsController];
}

- (void)setupFetchedResultsController
{
    if (self.tag.managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"any manyTags = %@", self.tag];
        
        NSArray *photos = [self.tag.managedObjectContext executeFetchRequest:request error:NULL];
        NSLog(@"PHOTO: %@", photos);
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.tag.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

@end
