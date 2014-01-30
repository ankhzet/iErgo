//
//  AETagsManagerSpec.m
//  Ergo
//
//  Created by Ankh on 30.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "Kiwi.h"

#import "AEErgo.h"
#import "AETagsManager.h"

SPEC_BEGIN(AETagsManagerSpec)

describe(@"Test AETagsManager", ^{

	__block NSMutableSet *tags = [NSMutableSet set];
	
	it(@"should properly manage tag sets", ^{

		AETag *tag;
		
		tag = [AETag mock];
		[[tag should] receive:@selector(uid) andReturn:@(1) withCountAtLeast:1];
		[tags addObject:tag];

		tag = [AETag mock];
		[[tag should] receive:@selector(uid) andReturn:@(5) withCountAtLeast:1];
		[tags addObject:tag];

		[[theValue([AETagsManager isTag:1 inSet:tags]) should] beYes];
		[[theValue([AETagsManager isTag:2 inSet:tags]) should] beNo];
		[[theValue([AETagsManager isTag:5 inSet:tags]) should] beYes];
	});
	
	it(@"should generate plain tag sets", ^{
		NSSet *plainTags = [AETagsManager plainTags:tags];
		[plainTags shouldNotBeNil];
		[[plainTags should] haveCountOf:2];
		
		[[plainTags member:@(1)] shouldNotBeNil];
		[[plainTags member:@(2)] shouldBeNil];
		[[plainTags member:@(5)] shouldNotBeNil];
	});
	
});
	
SPEC_END
