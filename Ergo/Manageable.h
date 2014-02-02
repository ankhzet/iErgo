//
//  Manageable.h
//  Ergo
//
//  Created by Ankh on 01.02.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Manageable, ManageableTitle, Tag;

@interface Manageable : NSManagedObject

@property (nonatomic, retain) NSString * annotation;
@property (nonatomic, retain) NSString * storage;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSSet *tags;
@property (nonatomic, retain) NSSet *titles;

@property (nonatomic, retain) NSSet *childs;
@property (nonatomic, retain) Manageable *parent;

@end

