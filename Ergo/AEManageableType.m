//
//  AEManageableType.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageableType.h"

#import "AETagsManager.h"

@interface AEManageableType (Private)
@end

@implementation AEManageableType

- (id) init {
	if (!(self = [super init]))
		return nil;
	
	self.subtypes = [NSSet set];
	self.subtags = [NSSet set];
	
	[AETagsManager registerTagProvider:self];
	
	return self;
}

- (AETag *) tagForUID:(NSUInteger)uid andGroup:(NSUInteger)group {
	return nil;
}

@end
