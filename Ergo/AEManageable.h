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

@interface AEManageable : Manageable

- (BOOL) addTitle:(NSString *) title;
- (BOOL) removeTitle:(NSString *) title;

- (NSMutableSet *) mutableTitles;

@end
