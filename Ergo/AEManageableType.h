//
//  AEManageableType.h
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AETagsManager.h"

typedef NS_ENUM(NSUInteger, AEErgoManageableType) {
	AEErgoManageableTypeManga = 1,
	AEErgoManageableTypeAnime = 2
};

@interface AEManageableType : NSObject <AEErgoTagProvider>

@property (nonatomic) AEErgoManageableType type;
@property (strong) NSSet *subtypes;
@property (strong) NSSet *subtags;

@end
