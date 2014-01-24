//
//  AEManageableTitle.h
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import "ManageableTitle.h"

#import "NSManagedObject+Commons.h"

@interface AEManageableTitle : ManageableTitle

+ (AEManageableTitle *) newTitle:(NSString *)title inContext:(NSManagedObjectContext *) context;

@end
