//
//  AEManageableMangaSeason.m
//  Ergo
//
//  Created by Ankh on 02.02.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageableTypeMangaSeason.h"

@implementation AEManageableTypeMangaSeason

- (id) init {
	if (!(self = [super init]))
		return nil;
	
	self.subtypes = [self tags:@[]
										forGroup:AEErgoTagGroupMangaSeasonSubtype];
	
	return self;
}



@end
