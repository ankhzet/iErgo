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
	
	// manga
	AEErgoTagGroupMangaSubtype = 2,
	AEErgoTagGroupMangaTag = 3,
	
	// anime
	AEErgoTagGroupAnimeSubtype = 4,
	AEErgoTagGroupAnimeTag = 5
};

@interface AETag : Tag

@end
