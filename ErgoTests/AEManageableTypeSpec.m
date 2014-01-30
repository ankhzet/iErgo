//
//  AEManageableTypeSpec.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//


#import "Kiwi.h"

#import "AEManageableTypeManager.h"
#import "AEManageableType.h"
#import "AEManageableTypeManga.h"
#import "AETagsManager.h"

SPEC_BEGIN(AEManageableTypeSpec)

describe(@"Testing AEManageableTypeManga", ^{
	__block AEManageableType *interface;
	
	interface = [AEManageableTypeManager interfaceForType:AEErgoManageableTypeManga];
	
	it(@"should be returned by manager for key AEErgoManageableTypeManga", ^{
		[interface shouldNotBeNil];
		[[theValue([interface type]) should] equal:theValue(AEErgoManageableTypeManga)];
		[[interface should] beKindOfClass:[AEManageableTypeManga class]];
	});
	
	it(@"should return proper subtype list", ^{
		NSSet *subtypes = [interface subtypes];
		[subtypes shouldNotBeNil];
		[[subtypes should] haveCountOf:2];
		
		[[theValue([AETagsManager isTag: AEErgoMangaSubtypeNormal inSet:subtypes]) should] beYes];
		[[theValue([AETagsManager isTag: AEErgoMangaSubtypeOneshot inSet:subtypes]) should] beYes];
		[[theValue([AETagsManager isTag: 5 inSet:subtypes]) should] beNo];
		
		NSSet *typeTags = [AETagsManager plainTags:subtypes];
		
		[[typeTags member:@(AEErgoMangaSubtypeNormal)] shouldNotBeNil];
		[[typeTags member:@(AEErgoMangaSubtypeOneshot)] shouldNotBeNil];
	});
	
	it(@"should return list of sub-tags", ^{
		NSSet *subtags = [interface subtags];
		[subtags shouldNotBeNil];
	});
	
});

SPEC_END