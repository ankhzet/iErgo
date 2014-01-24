//
//  AEDataManager.h
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEDataManager : NSObject

// CoreData stuff
@property (readonly, strong) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// directory name to store local data
@property (nonatomic, strong) NSString *localDataDirectory;

// file name to store coredata file
@property (nonatomic, strong) NSString *dataStorageFileName;

// flush CoreData to storage...
- (BOOL) saveContext;

+ (NSURL *) applicationDocumentsDirectory;

// absolute url for local data storage (e.g. database file)
- (NSURL *) localDataDirURL;

// absolute url of local coredata file
- (NSURL *) localStorageFileURL;


@end
