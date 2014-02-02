//
//  AEManageableType.h
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AETagsManager.h"

@class AEManageable;

typedef NSString *AEErgoManageableType;

@interface AEManageableType : NSObject <AEErgoTagProvider>

// manageable type (manga, anime, book, etc)
+ (AEErgoManageableType) type;

// manageable subtype (manga: oneshot, normal; anime: full-length, serial; book: story, antology)
@property (strong) NSSet *subtypes;
// manageable tags
@property (strong) NSSet *subtags;

- (NSMutableSet *) tags: (NSArray *) tags forGroup: (NSUInteger) group;
- (BOOL) deleteManageable: (AEManageable *) manageable;

@end
