//
//  PhotoCDTVC.m
//  CoreDataSPoT
//
//  Created by Angel on 5/15/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "PhotoCDTVC.h"
#import "Photo.h"

@interface PhotoCDTVC ()

@end

@implementation PhotoCDTVC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    
    if (indexPath) {
        if ([segue.identifier isEqualToString:@"detailToImageView"]) {
            Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
            photo.lastViewed = [NSDate date];
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
    
    if (photo.thumbnailData) {
        cell.imageView.image = [UIImage imageWithData:photo.thumbnailData];
    } else {
        NSURL *url = [NSURL URLWithString:photo.thumbnailURL];
        dispatch_queue_t thumbnailQueue = dispatch_queue_create("Fetch Thumbnail", NULL);
        dispatch_async(thumbnailQueue, ^{
            UIApplication *myApp = [UIApplication sharedApplication];
            myApp.networkActivityIndicatorVisible = YES;
            NSData *thumbnailData = [[NSData alloc] initWithContentsOfURL:url];
            myApp.networkActivityIndicatorVisible = NO;
            UIImage *thumbnailImage = [UIImage imageWithData:photo.thumbnailData];
            dispatch_async(dispatch_get_main_queue(), ^{
                photo.thumbnailData = thumbnailData;
                cell.imageView.image = thumbnailImage;
                [cell setNeedsDisplay];
            });
        });
    }
    
    return cell;
}

@end
