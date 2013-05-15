//
//  Tag.h
//  CoreDataSPoT
//
//  Created by Angel on 5/14/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * tagName;
@property (nonatomic, retain) NSSet *manyPhotos;
@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addManyPhotosObject:(Photo *)value;
- (void)removeManyPhotosObject:(Photo *)value;
- (void)addManyPhotos:(NSSet *)values;
- (void)removeManyPhotos:(NSSet *)values;

@end
