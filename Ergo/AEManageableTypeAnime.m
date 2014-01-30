//
//  AEManageableTypeAnime.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageableTypeAnime.h"

@implementation AEManageableTypeAnime

- (id) init {
	if (!(self = [super init]))
		return nil;
	
	self.type = AEErgoManageableTypeAnime;
	
	return self;
}

@end
