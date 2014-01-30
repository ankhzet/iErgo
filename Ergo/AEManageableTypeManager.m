//
//  AEManageableTypeManager.m
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "AEManageableTypeManager.h"

#import "AEManageableTypeManga.h"
#import "AEManageableTypeAnime.h"

@interface AEManageableTypeManager ()
@property (nonatomic, strong) NSMutableDictionary *interfaces;
@end

@implementation AEManageableTypeManager

- (void) loadInterfaces {
	[self addInterface:[AEManageableTypeManga new]];
	[self addInterface:[AEManageableTypeAnime new]];
}

// returns interface object for specified manageable type
+ (AEManageableType *) interfaceForType: (AEErgoManageableType) type {
	return [[self getInstance].interfaces objectForKey:@(type)];
}

- (id) init {
	if (!(self = [super init]))
		return nil;
	
	self.interfaces = [NSMutableDictionary dictionary];
	return self;
}

// singleton
+ (AEManageableTypeManager *) getInstance {
	static AEManageableTypeManager *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[AEManageableTypeManager alloc] init];
		[instance loadInterfaces];
	});
	
	return instance;
}

- (void) addInterface: (AEManageableType *) interface {
	[self.interfaces setObject:interface forKey:@([interface type])];
}

@end
