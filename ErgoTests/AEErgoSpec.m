
#import "Kiwi.h"

#import "AEErgo.h"

SPEC_BEGIN(AEErgoSpec)

describe(@"Testing Ergo", ^{
	context(@"singletone", ^{

		__block AEErgo *ergo = [AEErgo getInstance];
		
		it(@"AEErgo::getInstance", ^{
			[ergo shouldNotBeNil];
			
			[[[AEErgo getInstance] shouldNot] beIdenticalTo:ergo];
		});
		
	});
	
});

SPEC_END