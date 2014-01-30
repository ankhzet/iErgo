//
//  AEManageableTypeManager.h
//  Ergo
//
//  Created by Ankh on 25.01.14.
//  Copyright (c) 2014 Ankh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AEManageableType.h"

@interface AEManageableTypeManager : NSObject

+ (AEManageableType *) interfaceForType: (AEErgoManageableType) type;

@end
