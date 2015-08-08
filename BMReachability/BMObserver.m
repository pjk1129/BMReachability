//
//  BMObserver.m
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "BMObserver.h"

#define BMSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation BMObserver

+ (id)createWithObejct:(id)obejct
{
    return [[BMObserver alloc] initWithObject:obejct];
}

- (id)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        _observer = object;
    }
    return self;
}

- (void)noticeOberver:(SEL)selector
{
    if ([_observer respondsToSelector:selector]) {
        BMSuppressPerformSelectorLeakWarning([_observer performSelector:selector]);
    }
}

- (void)noticeOberver:(SEL)selector withObject:(id)object
{
    if ([_observer respondsToSelector:selector]) {
        BMSuppressPerformSelectorLeakWarning([_observer performSelector:selector withObject:object]);
    }
}

- (void)noticeOberver:(SEL)selector withObject:(id)object1 withObject:(id)object2
{
    if ([_observer respondsToSelector:selector]) {
        BMSuppressPerformSelectorLeakWarning([_observer performSelector:selector withObject:object1 withObject:object2]);
    }
}


@end
