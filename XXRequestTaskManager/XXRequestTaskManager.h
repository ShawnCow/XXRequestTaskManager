//
//  XXRequestTaskManager.h
//  XXRequestTaskManager
//
//  Created by Shawn on 2019/3/13.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+XXRequestTaskOpration.h"

@interface XXRequestTaskManager : NSObject

- (void)addTask:(id<XXRequestTaskOpration>)task key:(NSString *)key;

- (id<XXRequestTaskOpration>)taskForKey:(NSString *)key;

- (NSSet *)allTask;

- (void)cancelAllTask;

@end
