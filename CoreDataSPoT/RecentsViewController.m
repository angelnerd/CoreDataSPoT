//
//  RecentsViewController.m
//  CoreDataSPoT
//
//  Created by Angel on 5/14/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "RecentsViewController.h"
#import "DBObject.h"

@interface RecentsViewController ()

@end

@implementation RecentsViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Recents";
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastViewed" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        //request.predicate = [NSPredicate predicateWithFormat:@"lastViewed = %@", self.photo];
        request.predicate = nil;
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if (indexPath) {
        if ([segue.identifier isEqualToString:@"detailToImageView"]) {
            Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
            NSLog(@"PHOTO TO BE SENT: %@", photo);
            if ([segue.destinationViewController respondsToSelector:@selector(setPhoto:)]) {
                [segue.destinationViewController performSelector:@selector(setPhoto:) withObject:photo];
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo"];
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    return cell;
}


@end
