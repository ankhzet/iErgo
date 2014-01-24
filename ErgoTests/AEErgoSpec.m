
#import "Kiwi.h"

#import "AEErgo.h"

SPEC_BEGIN(AEErgoSpec)

describe(@"Testing Ergo", ^{
	context(@"singleton", ^{

		__block AEErgo *ergo;
		__block AEManageable *entity;
		
		it(@"AEErgo ::getInstance", ^{
			// make sure, singleton returns instance
			[(ergo = [AEErgo getInstance]) shouldNotBeNil];
			
			// make sure, instance not reinitialized
			[[[AEErgo getInstance] should] beIdenticalTo:ergo];
			
			// make sure, it's AEErgo instance
			[[ergo should] beKindOfClass:[AEErgo class]];
		});
		
		it(@"should create new manageable entities on request", ^{
			entity = [ergo newManageable];
			
			// new entity should be returned
			[entity shouldNotBeNil];
			
			// make sure, uid assigned
			[[theValue([entity uid]) shouldNot] equal:theValue(0)];
		});
		
	});
	
});

SPEC_END