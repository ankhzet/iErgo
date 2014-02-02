//
//  AEManageableSpec.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "Kiwi.h"

#import "AEErgo.h"
#import "AEManageableTypeManga.h"
#import "AEManageableTypeAnime.h"

SPEC_BEGIN(AEManageableSpec)

describe(@"Test AEManageable entity wrapper", ^{
	__block AEManageable *entity;
	
	it(@"should create entities with AEErgo object", ^{
		// new entity should be returned
		entity = [AEManageable newManageable:[AEManageableTypeManga type] forParent:nil];
		[entity shouldNotBeNil];
		[[entity should] beKindOfClass:[AEManageable class]];
	});
	
	it(@"should be properly initialized on creation", ^{
		// make sure, uid assigned
		[[[entity uid] shouldNot] equal:theValue(0)];
		
	});
	
	context(@"titles", ^{
		
		it(@"should be empty after entity creation", ^{
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
	
	context(@"manageable type", ^{
		it(@"should be set", ^{
			[[[entity type] should] equal:[AEManageableTypeManga type]];
			[[entity manageableType] shouldNotBeNil];
			[[[[[entity manageableType] class] type] should] equal:[AEManageableTypeManga type]];
		});
	});
	
	context(@"tags", ^{
		it(@"should properly add/delete tags", ^{
			AETag *tag1 = [AETagsManager tagFromUID:AEErgoCommonTagManageableOngoing andGroup:AEErgoTagGroupCommonTag];
			AETag *tag2 = [AETagsManager tagFromUID:AEErgoMangaSubtypeNormal andGroup:AEErgoTagGroupMangaSubtype];
			[entity addTag:tag1];
			[entity addTag:tag2];
			
			[[[entity tags] should] haveCountOf:2];
			
			[[theValue([AETagsManager isTag:AEErgoCommonTagManageableOngoing
														 forGroup:AEErgoTagGroupCommonTag
																inSet:[entity tags]]) should] beYes];
			[[theValue([AETagsManager isTag:AEErgoCommonTagViewed
														 forGroup:AEErgoTagGroupCommonTag
																inSet:[entity tags]]) should] beNo];
			[[theValue([AETagsManager isTag:AEErgoMangaSubtypeNormal
														 forGroup:AEErgoTagGroupMangaSubtype
																inSet:[entity tags]]) should] beYes];
			
			[entity removeTag:tag2];
			[[[entity tags] should] haveCountOf:1];
			[[theValue([AETagsManager isTag:AEErgoMangaSubtypeNormal
														 forGroup:AEErgoTagGroupMangaSubtype
																inSet:[entity tags]]) should] beNo];
		});
	});
	
	context(@"nodes tree", ^{
		__block AEManageable *child;
		it(@"should properly add childs", ^{
			[[[entity childs] should] haveCountOf:0]; // make sure there are no childs before check
			
			child = [AEManageable newManageable:[AEManageableTypeAnime type] forParent:entity];
			
			[child shouldNotBeNil];
			[[[child parent] should] equal:entity];

			[[[entity childs] should] haveCountOf:1]; // make sure child actually added

			[[[[entity childs] member:child] should] equal:child];
		});
		
		it(@"should properly delete childs", ^{
			BOOL deleted = [[child manageableType] deleteManageable:child];
			[[theValue(deleted) should] beYes];
			[[theValue([child isDeleted]) should] beYes];
			
			[[[entity childs] should] haveCountOf:0];
		});
	});
	
});

SPEC_END
