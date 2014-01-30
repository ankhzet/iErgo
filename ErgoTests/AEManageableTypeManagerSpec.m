//
//  AEManageableTypeManagerSpec.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "Kiwi.h"

#import "AEManageableTypeManager.h"

SPEC_BEGIN(AEManageableTypeManagerSpec)

describe(@"Testing AEManageableTypeManager", ^{
	__block AEManageableType *interface;
	
	it(@"should return proper interfaces for concrete types", ^{
		interface = [AEManageableTypeManager interfaceForType:AEErgoManageableTypeAnime];
		
		[interface shouldNotBeNil];
		[[theValue([interface type]) should] equal:theValue(AEErgoManageableTypeAnime)];
		
		interface = [AEManageableTypeManager interfaceForType:AEErgoManageableTypeManga];
		
		[interface shouldNotBeNil];
		[[theValue([interface type]) shouldNot] equal:theValue(AEErgoManageableTypeAnime)];
		
		interface = [AEManageableTypeManager interfaceForType:3];
		
		[interface shouldBeNil];
	});
});

SPEC_END