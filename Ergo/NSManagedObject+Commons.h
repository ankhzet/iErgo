//
//  NSManagedObject+Commons.h
//  
//
//  Created by Ankh on 24.01.14.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Commons)

+ (NSString *) entityName;
+ (id) insertInManagedObjectContext: (NSManagedObjectContext *) context;

@end
