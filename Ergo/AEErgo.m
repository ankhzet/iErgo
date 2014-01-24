//
//  AEErgo.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEErgo.h"

@implementation AEErgo

+ (AEErgo *) getInstance {
	static AEErgo *instance;
	static dispatch_once_t token;
	dispatch_once(&token, ^{
		instance = [[AEErgo alloc] init];
	});
	return instance;
}

- (AEManageable *) newManageable {
	return nil;
}

@end
