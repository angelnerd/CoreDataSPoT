//
//  TagViewController.m
//  CoreDataSPoT
//
//  Created by Angel on 5/10/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "TagViewController.h"
#import "Tag.h"

@interface TagViewController ()

@end

@implementation TagViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if (indexPath) {
        if ([segue.identifier isEqualToString:@"setTag"]) {
            Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
            NSLog(@"TAG: %@", tag);
            if ([segue.destinationViewController respondsToSelector:@selector(setTag:)]) {
                [segue.destinationViewController performSelector:@selector(setTag:) withObject:tag];
            }
        }
    }
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = nil; // all tags
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tag"];
    
    Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = tag.tagName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos", [tag.manyPhotos count]];
    
    return cell;
}

@end
