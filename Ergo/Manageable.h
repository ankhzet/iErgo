//
//  Manageable.h
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AEManageableTitle;

@interface Manageable : NSManagedObject

@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSSet *titles;

@end

