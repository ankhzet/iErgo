//
//  NSManagedObject+Commons.m
//  
//
//  Created by Ankh on 24.01.14.
//
//

#import "NSManagedObject+Commons.h"

@implementation NSManagedObject (Commons)

+ (NSString *) entityName {
	return [self className];
}

+ (id) insertInManagedObjectContext: (NSManagedObjectContext *) context {
	return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

@end
