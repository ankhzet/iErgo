//
//  AEErgo.h
//  Ergo
//
//  Created by Ankh on 24.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEDataManager.h"
#import "AEManageable.h"

@interface AEErgo : AEDataManager

+ (AEErgo *) getInstance;
- (AEManageable *) newManageable;

@end
