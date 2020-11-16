//
//  NSObject+RequestTaskManager.m
//  XXRequestTaskManager
//
//  Created by Shawn on 2019/3/13.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import "NSObject+RequestTaskManager.h"
#import "XXRequestTaskManager.h"
#include <objc/runtime.h>

@implementation NSObject (RequestTaskManager)

- (XXRequestTaskManager *)_xx_task_manager
{
    @synchronized (self) {
        NSString *key = [NSString stringWithFormat:@"_xx_task_manager_%p",self];
        XXRequestTaskManager *mgr = objc_getAssociatedObject(self, [key UTF8String]);
        if (mgr == nil) {
            mgr = [[XXRequestTaskManager alloc]init];
            objc_setAssociatedObject(self, [key UTF8String], mgr, OBJC_ASSOCIATION_RETAIN);
        }
        return mgr;
    }
}

- (void)xx_addTask:(id<XXRequestTaskOpration>)task key:(NSString *)key
{
    XXRequestTaskManager *mgr = [self _xx_task_manager];
    [mgr addTask:task key:key];
}

- (void)xx_addTask:(id<XXRequestTaskOpration>)task
{
    XXRequestTaskManager *mgr = [self _xx_task_manager];
    [mgr addTask:task key:nil];
}

- (id<XXRequestTaskOpration>)xx_TaskForKey:(NSString *)key
{
    XXRequestTaskManager *mgr = [self _xx_task_manager];
    return [mgr taskForKey:key];
}

@end
