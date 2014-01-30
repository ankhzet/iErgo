//
//  AETagsManager.h
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AETag.h"

@protocol AEErgoTagProvider <NSObject>
- (AETag *) tagForUID: (NSUInteger) uid andGroup: (NSUInteger) group;
@end

@interface AETagsManager : NSObject

+ (void) registerTagProvider: (id<AEErgoTagProvider>) provider;

+ (AETag *) newTag: (NSUInteger) uid forGroup: (NSUInteger) group withTitle: (NSString *) title andDescription: (NSString *) description;

+ (AETag *) tagFromUID: (NSUInteger) uid andGroup: (NSUInteger) group;

+ (BOOL) isTag: (NSUInteger) tag inSet: (NSSet *) tags;
+ (NSSet *) plainTags: (NSSet *) tags;

@end
