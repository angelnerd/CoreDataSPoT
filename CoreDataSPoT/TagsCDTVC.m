//
//  TagsCDTVC.m
//  CoreDataSPoT
//
//  Created by Angel on 5/15/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "TagsCDTVC.h"
#import "Tag.h"
#import "DBObject.h"

@interface TagsCDTVC ()

@end

@implementation TagsCDTVC

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
    
    [DBObject setDBObject:_managedObjectContext];
}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tag"];
    
    Tag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = tag.tagName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos", [tag.manyPhotos count]];
    
    return cell;
}

@end
