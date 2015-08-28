//
//  BMNetworkStatus.m
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "BMEnvObserverCenterNetworkStatus.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "AFNetworking.h"

@interface BMEnvObserverCenterNetworkStatus()

@property (nonatomic, strong) CTTelephonyNetworkInfo *telephonyNetworkInfo;
@property (nonatomic, assign) BMNetworkReachabilityStatus  networkStatus;
@property (nonatomic, strong) AFNetworkReachabilityManager  *reachabilityManager;


@end

@implementation BMEnvObserverCenterNetworkStatus

- (void)dealloc{
    [_reachabilityManager stopMonitoring];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (BMEnvObserverCenterNetworkStatus *)defaultCenter
{
    static BMEnvObserverCenterNetworkStatus *defaultNetCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultNetCenter = [[BMEnvObserverCenterNetworkStatus alloc] init];
    });
    return defaultNetCenter;
}

- (id)init{
    self = [super init];
    if (self) {
        _networkStatus = BMNetworkReachabilityStatusUnknown;
        _telephonyNetworkInfo = [CTTelephonyNetworkInfo new];
        [self startMonitoring];
    }
    return self;
}


- (void)startMonitoring
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:CTRadioAccessTechnologyDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reachabilityChanged:)
                                                name:AFNetworkingReachabilityDidChangeNotification
                                              object:nil];

    [self.reachabilityManager startMonitoring];
}

- (void)stopMonitoring
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AFNetworkingReachabilityDidChangeNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:CTRadioAccessTechnologyDidChangeNotification
                                                  object:nil];

    [self.reachabilityManager stopMonitoring];
}


- (void)reachabilityChanged:(NSNotification *)notification{
    BMNetworkReachabilityStatus fromStatus = _networkStatus;
    AFNetworkReachabilityStatus  status = self.reachabilityManager.networkReachabilityStatus;
    
    _networkStatus = [self updateNetworkStatusWithReachability:status];
    
    if (fromStatus == _networkStatus) {
        return;
    }
    
    for (BMObserver  *ob in self.observersAry) {
        id<BMNetworkStatusProtocol> observer = ob.observer;
        if ([observer respondsToSelector:@selector(networkStatusDidChangedFromStatus:toStatus:)]) {
            [observer networkStatusDidChangedFromStatus:fromStatus toStatus:_networkStatus];
        }
    }

}


- (BMNetworkReachabilityStatus)currentNetWorkStatus{
    return _networkStatus;
}

- (NSString *)currentNetWorkStatusString{
    if (_networkStatus == BMNetworkReachabilityStatusNotReachable) return @"无网络";
    if (_networkStatus == BMNetworkReachabilityStatusReachableViaWiFi) return @"Wifi";
    if (_networkStatus == BMNetworkReachabilityStatusReachableViaWWAN) return @"蜂窝网络";
    if (_networkStatus == BMNetworkReachabilityStatusReachableVia2G) return @"2G";
    if (_networkStatus == BMNetworkReachabilityStatusReachableVia3G) return @"3G";
    if (_networkStatus == BMNetworkReachabilityStatusReachableVia4G) return @"4G";
    return @"未知网络";
}

- (BMNetworkReachabilityStatus)updateNetworkStatusWithReachability:(AFNetworkReachabilityStatus)status
{
    if (status == AFNetworkReachabilityStatusNotReachable) return BMNetworkReachabilityStatusNotReachable;
    if (status == AFNetworkReachabilityStatusReachableViaWiFi) return BMNetworkReachabilityStatusReachableViaWiFi;
    
    NSString *technology = self.telephonyNetworkInfo.currentRadioAccessTechnology;
    if (status == AFNetworkReachabilityStatusReachableViaWWAN && technology!=nil) {
        if ([self accessNetworkVia2G:technology]) {
            return BMNetworkReachabilityStatusReachableVia2G;
        }
        
        if ([self accessNetworkVia3G:technology]){
            return BMNetworkReachabilityStatusReachableVia3G;
        }
        
        if ([self accessNetworkVia4G:technology]){
            return BMNetworkReachabilityStatusReachableVia4G;
        }
        
        return BMNetworkReachabilityStatusUnknown;
    }
    
    return BMNetworkReachabilityStatusUnknown;
    
}

- (BOOL)accessNetworkVia2G:(NSString *)currentRadioAccessTechnology{
    NSArray  *array = @[CTRadioAccessTechnologyEdge,CTRadioAccessTechnologyGPRS];
    return [array containsObject:currentRadioAccessTechnology];
}

- (BOOL)accessNetworkVia3G:(NSString *)currentRadioAccessTechnology{
    NSArray  *array = @[CTRadioAccessTechnologyHSDPA,
                        CTRadioAccessTechnologyWCDMA,
                        CTRadioAccessTechnologyHSUPA,
                        CTRadioAccessTechnologyCDMA1x,
                        CTRadioAccessTechnologyCDMAEVDORev0,
                        CTRadioAccessTechnologyCDMAEVDORevA,
                        CTRadioAccessTechnologyCDMAEVDORevB,
                        CTRadioAccessTechnologyeHRPD];
    return [array containsObject:currentRadioAccessTechnology];
}

- (BOOL)accessNetworkVia4G:(NSString *)currentRadioAccessTechnology{
    return [@[CTRadioAccessTechnologyLTE] containsObject:currentRadioAccessTechnology];
}

#pragma mark - getter
- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}

- (BOOL)isReachableViaWWAN {
    return self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}

- (BOOL)isReachableViaWiFi {
    return self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

- (AFNetworkReachabilityManager *)reachabilityManager{
    if (!_reachabilityManager) {
        _reachabilityManager = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    }
    return _reachabilityManager;
}

@end
