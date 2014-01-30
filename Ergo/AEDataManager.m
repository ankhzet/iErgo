//
//  AEDataManager.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEDataManager.h"

@implementation AEDataManager

- (id) init {
	if (!(self = [super init]))
		return nil;
	
	self.localDataDirectory = nil;
	self.dataStorageFileName = @"Ergo";
	
	return self;
}

// Returns the URL to the application's Documents directory.
+ (NSURL *) applicationDocumentsDirectory
{
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// path for local data storage (e.g. photos)
- (NSURL *) localDataDirURL {
	return self.localDataDirectory ? [[AEDataManager applicationDocumentsDirectory] URLByAppendingPathComponent:self.localDataDirectory] : [AEDataManager applicationDocumentsDirectory];
}

#pragma mark - CoreData stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

// url of local coredata file
- (NSURL *) localStorageFileURL {
	return [[AEDataManager applicationDocumentsDirectory] URLByAppendingPathComponent:self.dataStorageFileName];
}

// save CoreData-managed data
- (BOOL) saveContext {
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			return NO;
		}
	}
	
	return YES;
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *) managedObjectContext
{
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *) managedObjectModel
{
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Ergo" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	NSURL *storeURL = [self localStorageFileURL];

//	 [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
	
	
	// automigrate
	NSDictionary *options =
	@{
		NSMigratePersistentStoresAutomaticallyOption:@YES,
		NSInferMappingModelAutomaticallyOption:@YES
		};
	
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}

@end
