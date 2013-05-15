//
//  Tag+Create.h
//  CoreDataSPoT
//
//  Created by Angel on 5/10/13.
//  Copyright (c) 2013 edu.labs. All rights reserved.
//

#import "Tag.h"

@interface Tag (Create)

+ (NSSet *)tagsWithString:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
