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

+ (AETagsManager *) getInstance {
	static AETagsManager *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[AETagsManager alloc] init];
	});
	return instance;
}

+ (AETag *) getTagFromProviders: (NSUInteger) uid forGroup: (NSUInteger) group {
	for (id provider in [self getInstance].tagProviders) {
		AETag *tag;
    if ((tag = [provider tagForUID:uid andGroup:group]) != nil) {
			return tag;
		}
	}
	
	return nil;
}

+ (AETag *) newTag: (NSUInteger) uid forGroup: (NSUInteger) group withTitle: (NSString *) title andDescription: (NSString *) description {
	AETag *tag = [AETag insertInManagedObjectContext:[self getInstance].context];
	[tag setUid:@(uid)];
	[tag setGroup:@(group)];
	[tag setTitle:title];
	[tag setDescr:description];
	return tag;
}

+ (void) registerTagProvider: (id<AEErgoTagProvider>) provider {
	[[[self getInstance] tagProviders] addObject:provider];
}

- (NSArray *) existingTagsForGroup: (NSUInteger) group {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:self.tagEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"group = %d", group];
	[fetchRequest setPredicate:predicate];
	
	NSError *error = nil;
	
	return [self.context executeFetchRequest:fetchRequest error:&error];
}

+ (AETag *) tagFromUID: (NSUInteger) uid andGroup: (NSUInteger) group {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[self getInstance].tagEntity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %d", uid];
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

+ (BOOL) isTag: (NSUInteger) tag inSet: (NSSet *) tags {
	for (AETag *t in tags) {
    if ([t.uid integerValue] == tag) {
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
