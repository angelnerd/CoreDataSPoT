//
//  DBObject.h
//  CoreDataSPoT
//
//  Created by Angel on 5/15/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBObject : NSObject

+ (void)setDBObject:(NSManagedObjectContext *)context;
+ (NSManagedObjectContext *)context;

@end
