//
//  AEManageableType.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageableType.h"

#import "AEManageable.h"

@interface AEManageableType (Private)
@end

@implementation AEManageableType

+ (AEErgoManageableType) type {
	return [self className];
}


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

- (NSMutableSet *) tags: (NSArray *) tags forGroup: (NSUInteger) group {
	NSMutableSet *tagsSet = [NSMutableSet set];

	for (NSNumber *tag in tags)
    [tagsSet addObject:[AETagsManager tagFromUID:[tag integerValue]
																		 andGroup:group]];
	return tagsSet;
}

- (NSMutableSet *) commonTags {
	return [self tags:
	 @[
		 @(AEErgoCommonTagManageableIsSuspended),
		 @(AEErgoCommonTagManageableOngoing),
		 @(AEErgoCommonTagViewed),
		 @(AEErgoCommonTagViewSuspended),
		 
		 @(AEErgoJenreAction),
		 @(AEErgoJenreAdventure),
		 @(AEErgoJenreComedy)
		 ]
					 forGroup:AEErgoTagGroupCommonTag];
}

- (BOOL) deleteManageable: (AEManageable *) manageable {
	NSError *error = nil;
	
//	BOOL deleteable = [manageable validateForDelete:&error];
// fail, "validateForDelete:" is NOT a "isItSafeToDelete" analogue =\.
	
	BOOL deleteable = YES;

	if (deleteable) {
		[manageable setParent:nil];
  	[manageable.managedObjectContext deleteObject:manageable];
	} else
		NSLog(@"Can't delete manageable:\n%@", [error localizedDescription]);
	
	return deleteable;
}

@end
