//
//  AEManageableSpec.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "Kiwi.h"

#import "AEErgo.h"

SPEC_BEGIN(AEManageableSpec)

describe(@"Test AEManageable entity wrapper", ^{
	__block AEManageable *entity;
	
	it(@"should create entities with AEErgo object", ^{
		entity = [[AEErgo getInstance] newManageable];
		
		[entity shouldNotBeNil];
		
		[[entity should] beKindOfClass:[AEManageable class]];
	});
	
	it(@"should be properly initialized on creation", ^{
		// make sure, uid assigned
		[[[entity uid] shouldNot] equal:theValue(0)];
		
	});
	
	it(@"titles should be empty after entity creation", ^{
		[[[entity titles] should] beEmpty];
	});
	
	it(@"should add titles properly", ^{
		[[theValue([entity addTitle:@"Title 1"]) should] beYes];
		[[theValue([entity addTitle:@"Title 2"]) should] beYes];
		[[theValue([entity addTitle:@"Title 3"]) should] beYes];
		
		[[[entity should] have:3] titles];
	});
	
	it(@"should not add duplicated titles", ^{
		[[theValue([entity addTitle:@"Title 2"]) should] beNo];
		[[theValue([entity addTitle:@"Title 4"]) should] beYes];
		[[theValue([entity addTitle:@"Title 1"]) should] beNo];
		
		[[[entity should] have:4] titles];
	});
	
	it(@"should delete titles properly", ^{
		[[theValue([entity removeTitle:@"Title 3"]) should] beYes];
		
		[[[entity should] have:3] titles];
	});
	
});

SPEC_END
