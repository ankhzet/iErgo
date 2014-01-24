
#import "Kiwi.h"

#import "AEDataManager.h"

SPEC_BEGIN(AEDataManagerSpec)

describe(@"Testing AEDataManager", ^{
	__block AEDataManager *manager;
	
	it(@"should be properly initialized", ^{
		[(manager = [[AEDataManager alloc] init]) shouldNotBeNil];
	});
	
	it(@"should initialize Core Data objects", ^{
		[[manager managedObjectContext] shouldNotBeNil];
		[[manager managedObjectModel] shouldNotBeNil];
		[[manager persistentStoreCoordinator] shouldNotBeNil];
	});
	
	it(@"should save data to database", ^{
		[[theValue([manager saveContext]) should] beYes];
	});
	
	it(@"should provide app directory info", ^{
		[[manager localDataDirURL] shouldNotBeNil];
	});
	
});

SPEC_END