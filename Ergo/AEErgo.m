//
//  AEErgo.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEErgo.h"

@implementation AEErgo

+ (AEErgo *) getInstance {
	static AEErgo *instance;
	static dispatch_once_t token;
	dispatch_once(&token, ^{
		instance = [[AEErgo alloc] init];
	});
	return instance;
}

- (AEManageable *) newManageable {
	NSNumber *maxID = @0;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *fetchEntity = [NSEntityDescription entityForName:[AEManageable entityName]
																						inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:fetchEntity];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"uid"
																																 ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[fetchRequest setFetchLimit:1];
	
	NSError *error = nil;
	NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if ([fetchedObjects count]) {
    maxID = [fetchedObjects[0] uid];
	}

	AEManageable *entity = [NSEntityDescription insertNewObjectForEntityForName:[AEManageable entityName] inManagedObjectContext:self.managedObjectContext];
	
	[entity setUid:@([maxID integerValue] + 1)];
	return entity;
}

@end
