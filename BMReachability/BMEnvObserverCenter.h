//
//  BMEnvObserverCenter.h
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMObserver.h"

@interface BMEnvObserverCenter : NSObject

@property (nonatomic, strong) NSMutableArray * observersAry;

- (void)addEnvObserver:(id)observer;
- (void)removeEnvObserver:(id)observer;
- (void)removeAllEnvObservers;

- (void)noticeObervers:(SEL)selector;
- (void)noticeObervers:(SEL)selector withObject:(id)object;
- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2;


@end
