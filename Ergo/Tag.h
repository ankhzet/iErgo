//
//  Tag.h
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AEManageable;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * group;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSSet *manageables;
@end
