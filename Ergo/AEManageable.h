//
//  AEManageable.h
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manageable.h"

#import "NSManagedObject+Commons.h"
#import "AEManageableType.h"

@interface AEManageable : Manageable

@property (nonatomic, strong) AEManageableType *manageableType;

+ (AEManageable *) newManageable: (AEErgoManageableType) type forParent: (AEManageable *) parent;

- (BOOL) addTitle:(NSString *) title;
- (BOOL) removeTitle:(NSString *) title;

- (void) addTag:(AETag *)tag;
- (void) removeTag:(AETag *)tag;

- (NSMutableSet *) mutableTitles;

@end
