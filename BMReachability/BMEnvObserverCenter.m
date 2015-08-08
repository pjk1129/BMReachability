//
//  BMEnvObserverCenter.m
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "BMEnvObserverCenter.h"

static dispatch_queue_t env_observer_center_processing_queue() {
    static dispatch_queue_t bm_env_observer_center_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bm_env_observer_center_processing_queue = dispatch_queue_create("com.baidu.env.observer.center.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    return bm_env_observer_center_processing_queue;
}

@implementation BMEnvObserverCenter

- (void)dealloc{
    _observersAry = nil;;
}

- (id)init{
    self = [super init];
    if (self) {
        _observersAry = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)addEnvObserver:(id)observer{
    dispatch_barrier_async(env_observer_center_processing_queue(), ^{
        if (observer == nil) {
            return;
        }

        for (BMObserver * ob in _observersAry) {
            if (ob.observer == observer) {
                return;
            }
        }
        
        BMObserver * ob = [BMObserver createWithObejct:observer];
        [_observersAry addObject:ob];
    });
}

- (void)removeEnvObserver:(id)observer
{
    dispatch_barrier_async(env_observer_center_processing_queue(), ^{
        for (NSInteger i = 0; i < [_observersAry count]; i++) {
            BMObserver * ob = [_observersAry objectAtIndex:i];
            if (ob.observer == observer) {
                [_observersAry removeObjectAtIndex:i];
                return;
            }
        }
    });
}

- (void)removeAllEnvObservers
{
    dispatch_barrier_async(env_observer_center_processing_queue(), ^{
        [_observersAry removeAllObjects];
    });
}

- (void)noticeObervers:(SEL)selector
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BMObserver * observer = obj;
        [observer noticeOberver:selector];
    }];
}

- (void)noticeObervers:(SEL)selector withObject:(id)object
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BMObserver * observer = obj;
        [observer noticeOberver:selector withObject:object];
    }];
}

- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BMObserver * observer = obj;
        [observer noticeOberver:selector withObject:object1 withObject:object2];
    }];
}

@end
