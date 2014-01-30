//
//  AEManageableTitle.m
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageableTitle.h"

@implementation AEManageableTitle

+ (NSString *) entityName {
	return @"ManageableTitle";
}

+ (AEManageableTitle *) newTitle:(NSString *)title inContext:(NSManagedObjectContext *) context {
	AEManageableTitle *entity = [self insertInManagedObjectContext:context];
	
	[entity setTitle:title];
	return entity;
}

@end
