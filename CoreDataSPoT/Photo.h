//
//  Photo.h
//  CoreDataSPoT
//
//  Created by Angel on 5/14/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSDate * lastViewed;
@property (nonatomic, retain) NSString * photoID;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * uploadDate;
@property (nonatomic, retain) NSSet *manyTags;
@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addManyTagsObject:(Tag *)value;
- (void)removeManyTagsObject:(Tag *)value;
- (void)addManyTags:(NSSet *)values;
- (void)removeManyTags:(NSSet *)values;

@end
