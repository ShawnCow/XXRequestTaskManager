//
//  NSObject+RequestTaskManager.h
//  XXRequestTaskManager
//
//  Created by Shawn on 2019/3/13.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLSessionTask+RequestTaskOpration.h"

@interface NSObject (RequestTaskManager)

- (void)xx_addTask:(id<XXRequestTaskOpration>)task;

- (void)xx_addTask:(id<XXRequestTaskOpration>)task key:(NSString *)key;

- (id<XXRequestTaskOpration>)xx_TaskForKey:(NSString *)key;

@end
