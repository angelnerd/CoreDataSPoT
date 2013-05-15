//
//  DBObject.m
//  CoreDataSPoT
//
//  Created by Angel on 5/15/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "DBObject.h"

@interface DBObject()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation DBObject

+ (DBObject *)sharedContext
{
    static DBObject *sharedContext = nil;
    static dispatch_once_t onceAround;
    dispatch_once(&onceAround, ^{
        sharedContext = [[DBObject alloc] init];
    });
    
    return sharedContext;
}

+ (void)setDBObject:(NSManagedObjectContext *)context
{
    [self sharedContext].context = context;
}

+ (NSManagedObjectContext *)context
{
    return [self sharedContext].context;
}

@end
