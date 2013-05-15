//
//  Tag+Create.m
//  CoreDataSPoT
//
//  Created by Angel on 5/10/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "Tag+Create.h"

@implementation Tag (Create)

+ (NSArray *)ignoreTags
{
    return @[@"cs193pspot", @"portrait", @"landscape"];
}

+ (NSSet *)tagsWithString:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSMutableArray *currentPhotoTags = [[name componentsSeparatedByString:@" "] mutableCopy];
    [currentPhotoTags removeObjectsInArray:[self ignoreTags]];
    if (![currentPhotoTags count]) return nil;
    
    Tag *tag = nil;
    NSMutableSet *tags = [NSMutableSet setWithCapacity:[currentPhotoTags count]];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    for (NSString *tagName in currentPhotoTags) {
        tag = nil;
        request.predicate = [NSPredicate predicateWithFormat:@"tagName = %@", [tagName capitalizedString]];
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            NSLog(@"Error adding tags to CoreData. %@", error);
        } else if (![matches count]) {
            tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:context];
            tag.tagName = [tagName capitalizedString];
        } else {
            tag = [matches lastObject];
        }
        
        if (tag) [tags addObject:tag];
    }

    return tags;
}

@end
