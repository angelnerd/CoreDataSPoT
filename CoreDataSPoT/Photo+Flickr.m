//
//  Photo+Flickr.m
//  CoreDataSPoT
//
//  Created by Angel on 5/10/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Tag+Create.h"

@implementation Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photo *photo = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"photoID = %@", [photoDictionary[FLICKR_PHOTO_ID] description]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        // error handler
    } else if (![matches count]) {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        photo.photoID = [photoDictionary[FLICKR_PHOTO_ID] description];
        photo.title = [photoDictionary[FLICKR_PHOTO_TITLE] description];
        photo.subtitle = [[photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] description];
        photo.photoURL = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
        photo.thumbnailURL = [[FlickrFetcher urlForPhoto:photoDictionary format:FlickrPhotoFormatSquare] absoluteString];
        NSString *tagName = [photoDictionary[FLICKR_TAGS] description];
        NSSet *tags = [Tag tagsWithString:tagName inManagedObjectContext:context];
        photo.manyTags = tags;
    } else {
        photo = [matches lastObject];
    }
    
    return photo;
}

@end
