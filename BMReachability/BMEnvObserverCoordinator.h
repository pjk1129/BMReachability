//
//  BMEnvObserverCoordinator.h
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMEnvObserverCenterNetworkStatus.h"


#define BMAddNetworkStatusObserver(X)       [BMEnvObserverCoordinator addNetworkStatusObserver:X]
#define BMRemoveNetworkStatusObserver(X)    [BMEnvObserverCoordinator removeNetworkStatusObserver:X]

@interface BMEnvObserverCoordinator : NSObject

+ (void)addNetworkStatusObserver:(id<BMNetworkStatusProtocol>)observer;
+ (void)removeNetworkStatusObserver:(id<BMNetworkStatusProtocol>)observer;

@end
