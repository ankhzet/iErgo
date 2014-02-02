//
//  AEManageable.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageable.h"

#import "AEManageableTitle.h"
#import "AEErgo.h"
#import "AEManageableTypeManager.h"

@implementation AEManageable
@synthesize manageableType = _manageableType;

+ (NSString *) entityName {
	return @"Manageable";
}

+ (AEManageable *) newManageable: (AEErgoManageableType) type forParent: (AEManageable *) parent {
	NSNumber *maxID = @0;
	NSManagedObjectContext *context = [AEErgo getInstance].managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *fetchEntity = [NSEntityDescription entityForName:[self entityName]
																								 inManagedObjectContext:context];
	[fetchRequest setEntity:fetchEntity];

	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@", type];
	[fetchRequest setPredicate:predicate];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid"
																																 ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[fetchRequest setFetchLimit:1];
	
	NSError *error = nil;
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	if ([fetchedObjects count]) {
    maxID = [fetchedObjects[0] uid];
	}
	
	AEManageable *entity = [NSEntityDescription insertNewObjectForEntityForName:[AEManageable entityName]
																											 inManagedObjectContext:context];
	
	[entity setUid:@([maxID integerValue] + 1)];
	[entity setType:type];
	[entity setManageableType:[AEManageableTypeManager interfaceForType:type]];
	[entity setParent:parent];
	return entity;
}

- (NSMutableSet *) mutableTitles {
	return [self mutableSetValueForKey:@"titles"];
}

- (AEManageableTitle *) hasTitle: (NSString *) title {
	__block AEManageableTitle *found = nil;
	[[self titles] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		if ([[(AEManageableTitle *) obj title] isEqualToString:title]) {
			*stop = YES;
			found = obj;
			return;
		}
	}];
	return found;
}

- (BOOL) addTitle:(NSString *) title {
	if ([self hasTitle:title])
		return NO;
	
	[self.mutableTitles addObject: [AEManageableTitle newTitle:title inContext:[self managedObjectContext]]];
	return YES;
}

- (BOOL) removeTitle:(NSString *) title {
	AEManageableTitle *has = [self hasTitle:title];
	if (!has)
		return NO;
	
	[self.mutableTitles removeObject:has];
	return YES;
}

- (void)addTag:(AETag *)tag {
	[[self mutableSetValueForKey:@"tags"] addObject:tag];
}

- (void)removeTag:(AETag *)tag {
	[[self mutableSetValueForKey:@"tags"] removeObject:tag];
}

@end
