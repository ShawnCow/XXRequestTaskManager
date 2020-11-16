//
//  XXRequestTaskManager.m
//  XXRequestTaskManager
//
//  Created by Shawn on 2019/3/13.
//  Copyright © 2019 Shawn. All rights reserved.
//

#import "XXRequestTaskManager.h"

@interface XXRequestTaskManager ()
{
    NSHashTable *table;
    NSMapTable *mapTable;
    NSRecursiveLock *lock;
}
@end

@implementation XXRequestTaskManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        table = [NSHashTable weakObjectsHashTable];
        mapTable = [NSMapTable strongToWeakObjectsMapTable];
        lock = [NSRecursiveLock new];
    }
    return self;
}

- (void)addTask:(id<XXRequestTaskOpration>)task key:(NSString *)key
{
    if (task == nil) {
        return;
    }
    if (key) {
        [lock lock];
        id<XXRequestTaskOpration> oldTask = [mapTable objectForKey:key];
        [mapTable setObject:task forKey:key];
        [lock unlock];
        [oldTask cancel];
    }else
    {
        [lock lock];
        if ([table containsObject:task] == NO) {
            [table addObject:task];
        }
        [lock unlock];
    }
}

- (id<XXRequestTaskOpration>)taskForKey:(NSString *)key
{
    if (key == nil) {
        return nil;
    }
    [lock lock];
    id<XXRequestTaskOpration> task = [mapTable objectForKey:key];
    [lock unlock];
    return task;
}

- (void)cancelAllTask
{
    NSSet *items = [self allTask];
    for (id<XXRequestTaskOpration>task in items) {
        [task cancel];
    }
}

- (NSSet *)allTask
{
    NSMutableSet *sets = [NSMutableSet set];
    [lock lock];
    [sets addObjectsFromArray:table.allObjects];
    NSEnumerator *objectEnum = [mapTable objectEnumerator];
    for (id<XXRequestTaskOpration> task in objectEnum) {
        [sets addObject:task];
    }
    [lock unlock];
    return sets;
}

- (void)dealloc
{
    [self cancelAllTask];
}

@end
