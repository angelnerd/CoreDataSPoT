//
//  Photo+Flickr.h
//  CoreDataSPoT
//
//  Created by Angel on 5/10/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context;

@end
