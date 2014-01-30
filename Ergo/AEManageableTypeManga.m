//
//  AEManageableTypeManga.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageableTypeManga.h"

@implementation AEManageableTypeManga

- (id) init {
	if (!(self = [super init]))
		return nil;
	
	self.type = AEErgoManageableTypeManga;
	
	NSMutableSet *tags = [NSMutableSet set];
	
	for (NSNumber *tag in @[@(AEErgoMangaSubtypeNormal), @(AEErgoMangaSubtypeOneshot)])
    [tags addObject:[AETagsManager tagFromUID:[tag integerValue]
																		 andGroup:AEErgoTagGroupMangaSubtype]];
	
	self.subtypes = tags;
	
	return self;
}

- (AETag *) tagForUID:(NSUInteger)uid andGroup:(NSUInteger)group {
	switch (group) {
		case AEErgoTagGroupMangaSubtype:
			switch (uid) {
				case AEErgoMangaSubtypeNormal:
					return [AETagsManager newTag:uid forGroup:group withTitle:@"Normal" andDescription:@"Manga with more than one chapters"];
				case AEErgoMangaSubtypeOneshot:
					return [AETagsManager newTag:uid forGroup:group withTitle:@"Oneshot" andDescription:@"Manga with only one chapter"];
			}

			
		default:;
	}
	return nil;
}

@end
