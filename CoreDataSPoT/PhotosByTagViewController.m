//
//  PhotosByTagViewController.m
//  CoreDataSPoT
//
//  Created by Angel on 5/13/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "PhotosByTagViewController.h"
#import "Photo.h"

@interface PhotosByTagViewController ()

@end

@implementation PhotosByTagViewController

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
