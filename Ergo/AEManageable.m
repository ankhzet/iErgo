//
//  AEManageable.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageable.h"

#import "AEManageableTitle.h"

@implementation AEManageable

+ (NSString *) entityName {
	return @"Manageable";
}

- (NSMutableSet *) mutableTitles {
	return [self mutableSetValueForKey:@"titles"];
}

- (AEManageableTitle *) hasTitle: (NSString *) title {
	__block AEManageableTitle *found = nil;
	[[self titles] enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		if ([[(AEManageableTitle *) obj title] isEqualToString:title]) {
			*stop = YES;
			found = obj;
			return;
		}
	}];
	return found;
}

- (BOOL) addTitle:(NSString *) title {
	if ([self hasTitle:title])
		return NO;
	
	[self.mutableTitles addObject: [AEManageableTitle newTitle:title inContext:[self managedObjectContext]]];
	return YES;
}

- (BOOL) removeTitle:(NSString *) title {
	AEManageableTitle *has = [self hasTitle:title];
	if (!has)
		return NO;
	
	[self.mutableTitles removeObject:has];
	return YES;
}

@end
