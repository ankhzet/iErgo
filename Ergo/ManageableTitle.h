//
//  ManageableTitle.h
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AEManageable;

@interface ManageableTitle : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) AEManageable *manageable;

@end
