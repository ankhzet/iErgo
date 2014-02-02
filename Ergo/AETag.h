//
//  AETag.h
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Tag.h"
#import "NSManagedObject+Commons.h"

typedef NS_ENUM(NSUInteger, AEErgoTagGroup) {
	AEErgoTagGroupManageableType = 1,
	AEErgoTagGroupCommonTag = 2,
	
	// manga
	AEErgoTagGroupMangaSubtype = 100,
	// manga season
	AEErgoTagGroupMangaSeasonSubtype = 101,
	
	// anime
	AEErgoTagGroupAnimeSubtype = 200
};

typedef NS_ENUM(NSUInteger, AEErgoCommonTag) {
	// common flags
	AEErgoCommonTagManageableOngoing = 1,
	AEErgoCommonTagViewed = 2,
	AEErgoCommonTagManageableIsSuspended = 3,
	AEErgoCommonTagViewSuspended = 4,
	
	// manga tags
	AEErgoMangaTagManga = 5,
	
	// jenres
	AEErgoJenreAdventure = 10, // 10, not 6, give some space for common tags
	AEErgoJenreAction = 11,
	AEErgoJenreComedy = 12
	// ... and over 9000 more
};

@interface AETag : Tag

@end
