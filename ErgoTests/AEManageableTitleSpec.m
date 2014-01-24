//
//  AEManageableTitleSpec.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "Kiwi.h"

#import "AEErgo.h"
#import "AEManageableTitle.h"

SPEC_BEGIN(AEManageableTitleSpec)

describe(@"Testing AEManageableTitle entity wrapper", ^{
	__block AEManageableTitle *entity;
	__block NSManagedObjectContext *context;
	
	it(@"managed object context should be initialized", ^{
		context = [[AEErgo getInstance] managedObjectContext];
		
		[context shouldNotBeNil];
	});
	
	it(@"should be properly instantiated", ^{
		entity = [AEManageableTitle newTitle:@"some title" inContext:context];
		
		[entity shouldNotBeNil];
		
		[[entity should] beKindOfClass:[AEManageableTitle class]];
		
		[[[entity title] should] equal:@"some title"];
		
		[[entity manageable] shouldBeNil];
	});
	
	it(@"should be deleteable", ^{
		[context deleteObject:entity];
	});
	
});

SPEC_END
