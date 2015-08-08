//
//  BMNetworkStatus.h
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "BMEnvObserverCenter.h"

typedef NS_ENUM(NSInteger, BMNetworkReachabilityStatus) {
    BMNetworkReachabilityStatusUnknown          = -1,
    BMNetworkReachabilityStatusNotReachable     = 0,
    BMNetworkReachabilityStatusReachableViaWWAN = 1,
    BMNetworkReachabilityStatusReachableViaWiFi = 2,
    BMNetworkReachabilityStatusReachableVia2G   = 3,
    BMNetworkReachabilityStatusReachableVia3G   = 4,
    BMNetworkReachabilityStatusReachableVia4G   = 5,
};

@protocol BMNetworkStatusProtocol <NSObject>
@optional
- (void)networkStatusDidChangedFromStatus:(BMNetworkReachabilityStatus)fromStatus
                                 toStatus:(BMNetworkReachabilityStatus)toStatus;

@end

@interface BMEnvObserverCenterNetworkStatus : BMEnvObserverCenter

/**
 Whether or not the network is currently reachable.
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

/**
 Whether or not the network is currently reachable via WWAN.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

/**
 Whether or not the network is currently reachable via WiFi.
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;



+ (BMEnvObserverCenterNetworkStatus *)defaultCenter;

/*!
 * Start listening for reachability notifications on the current run loop.
 */
- (void)startMonitoring;
- (void)stopMonitoring;

/**
 *  获取当前网络状态
 *
 *  @return 枚举类型
 */
- (BMNetworkReachabilityStatus)currentNetWorkStatus;

/**
 *  获取当前网络状态
 *
 *  @return 状态字符
 */
- (NSString *)currentNetWorkStatusString;

@end
