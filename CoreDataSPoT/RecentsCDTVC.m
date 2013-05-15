//
//  RecentsCDTVC.m
//  CoreDataSPoT
//
//  Created by Angel on 5/15/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "RecentsCDTVC.h"
#import "DBObject.h"

@interface RecentsCDTVC ()

@end

@implementation RecentsCDTVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.managedObjectContext) self.managedObjectContext = [DBObject context];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    super.managedObjectContext = managedObjectContext;
    
    if (self.managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastViewed" ascending:NO]];
        NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
        request.predicate = [NSPredicate predicateWithFormat:@"(lastViewed > %@)", yesterday];
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
    
    [DBObject setDBObject:self.managedObjectContext];
}

@end
