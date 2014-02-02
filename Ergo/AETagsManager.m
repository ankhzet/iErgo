//
//  AETagsContainer.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AETagsManager.h"

#import "AEErgo.h"

@interface AETagsManager ()
@property (strong) NSMutableArray *tagProviders;
@property (weak) NSManagedObjectContext *context;
@property (strong) NSEntityDescription *tagEntity;
@end

@implementation AETagsManager

- (id) init {
	if (!(self = [super init]))
		return nil;
	
	self.tagProviders = [NSMutableArray array];
	self.context = [[AEErgo getInstance] managedObjectContext];
	
	self.tagEntity = [NSEntityDescription entityForName:[AETag entityName] inManagedObjectContext:self.context];
	
	return self;
}

// singletone %)
+ (AETagsManager *) getInstance {
	static AETagsManager *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[AETagsManager alloc] init];
	});
	return instance;
}

#pragma mark - Tag providers

+ (AETag *) getTagFromProviders: (NSUInteger) uid forGroup: (NSUInteger) group {
	AETag *tag;
	for (id provider in [self getInstance].tagProviders) {
    if ((tag = [provider tagForUID:uid andGroup:group]) != nil) {
			return tag;
		}
	}
	
	tag = [[self getInstance] tagForUID:uid andGroup:group];
	NSAssert(tag, @"Unknown tag {@ID#%@, GROUP#%@}", @(uid), @(group));
	return tag;
}

+ (void) registerTagProvider: (id<AEErgoTagProvider>) provider {
	[[[self getInstance] tagProviders] addObject:provider];
}

#pragma mark - Tag objects instantiation

+ (AETag *) newTag: (NSUInteger) uid forGroup: (NSUInteger) group withTitle: (NSString *) title andDescription: (NSString *) description {
	AETag *tag = [AETag insertInManagedObjectContext:[self getInstance].context];
	[tag setUid:@(uid)];
	[tag setGroup:@(group)];
	[tag setTitle:title];
	[tag setDescr:description];
	return tag;
}

// TODO: move predefined tags declaration into .plist
- (AETag *) tagForUID: (NSUInteger) uid andGroup: (NSUInteger) group {
	switch (group) {
		case AEErgoTagGroupCommonTag:
			switch (uid) {
				// common tags
				case AEErgoCommonTagManageableOngoing:
					return [AETagsManager newTag:uid
															forGroup:group
														 withTitle:@"Ongoing"
												andDescription:@"Not yet finished"];
				case AEErgoCommonTagManageableIsSuspended:
					return [AETagsManager newTag:uid
															forGroup:group
														 withTitle:@"Suspended"
												andDescription:@"Production suspended"];
				case AEErgoCommonTagViewed:
					return [AETagsManager newTag:uid
															forGroup:group
														 withTitle:@"Viewed"
												andDescription:@"Already viewed"];
				case AEErgoCommonTagViewSuspended:
					return [AETagsManager newTag:uid
															forGroup:group
														 withTitle:@"View suspended"
												andDescription:@"View suspended"];
					
				// common jenres
				case AEErgoJenreAction:
					return [AETagsManager newTag:uid
															forGroup:group
														 withTitle:@"Action"
												andDescription:@"Action"];
				case AEErgoJenreAdventure:
					return [AETagsManager newTag:uid
															forGroup:group
														 withTitle:@"Adventure"
												andDescription:@"Adventure"];
				case AEErgoJenreComedy:
					return [AETagsManager newTag:uid
															forGroup:group
														 withTitle:@"Comedy"
												andDescription:@"Comedy"];
			}
			
			
		default:;
	}
	return nil;
}

+ (AETag *) tagFromUID: (NSUInteger) uid andGroup: (NSUInteger) group {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[self getInstance].tagEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %d and group = %d", uid, group];
	[fetchRequest setPredicate:predicate];
	[fetchRequest setFetchLimit:1];
	
	AETag *tag = nil;
	NSError *error = nil;
	NSArray *tags = [[self getInstance].context executeFetchRequest:fetchRequest error:&error];
	if ([tags count])
		tag = tags[0];
	else
		tag = [self getTagFromProviders:uid forGroup:group];
	
	return tag;
}

#pragma mark - Tag groups/sets

- (NSArray *) existingTagsForGroup: (NSUInteger) group {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:self.tagEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"group = %d", group];
	[fetchRequest setPredicate:predicate];
	
	NSError *error = nil;
	
	return [self.context executeFetchRequest:fetchRequest error:&error];
}

+ (BOOL) isTag: (NSUInteger) tag forGroup: (NSUInteger) group inSet: (NSSet *) tags {
	for (AETag *t in tags) {
    if (([t.uid integerValue] == tag) && ([t.group integerValue] == group)) {
			return YES;
		}
	}
	
	return NO;
}

+ (NSSet *) plainTags: (NSSet *) tags {
	NSMutableSet *plain = [NSMutableSet set];
	for (AETag *tag in tags) {
    [plain addObject:tag.uid];
	}
	
	return plain;
}

@end
