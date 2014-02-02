//
//  AEManageableTypeManagerSpec.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "Kiwi.h"

#import "AEManageableTypeManager.h"
#import "AEManageableTypeAnime.h"
#import "AEManageableTypeManga.h"

SPEC_BEGIN(AEManageableTypeManagerSpec)

describe(@"Testing AEManageableTypeManager", ^{
	__block AEManageableType *interface1;
	__block AEManageableType *interface2;
	
	it(@"should return proper interfaces for concrete types", ^{
		interface1 = [AEManageableTypeManager interfaceForType:[AEManageableTypeAnime type]];
		interface2 = [AEManageableTypeManager interfaceForType:[AEManageableTypeManga type]];
		
		[interface1 shouldNotBeNil];
		[interface2 shouldNotBeNil];
		
		AEErgoManageableType type1 = [[interface1 class] type];
		AEErgoManageableType type2 = [[interface2 class] type];

		[[type1 should] equal:[AEManageableTypeAnime type]];
		[[type2 should] equal:[AEManageableTypeManga type]];
		[[type1 shouldNot] equal:type2];
		
		interface1 = [AEManageableTypeManager interfaceForType:nil];
		
		[interface1 shouldBeNil];
	});
});

SPEC_END