//
//  BMEnvObserverCoordinator.m
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "BMEnvObserverCoordinator.h"

@implementation BMEnvObserverCoordinator

+ (void)addNetworkStatusObserver:(id<BMNetworkStatusProtocol>)observer
{
    [[BMEnvObserverCenterNetworkStatus defaultCenter] addEnvObserver:observer];
}

+ (void)removeNetworkStatusObserver:(id<BMNetworkStatusProtocol>)observer
{
    [[BMEnvObserverCenterNetworkStatus defaultCenter] removeEnvObserver:observer];
}

@end
