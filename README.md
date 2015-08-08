# BMReachability
# BMReachability

1. What's BMReachability?

BMReachability monitors the reachability of domains for both WWAN and WiFi network interfaces.
This is a drop-in replacement for AFNetworking's Reachability class. 
It is ARC-compatible, and it uses the delegate methods to notify of network interface changes. 
It supports the use of blocks for when the network becomes reachable and unreachable.
It provides monitor 2G/3G/4G network interface changes.


2. iOS Requirements

requires iOS 7.0 minimum deployement version.


3. How To Use

Just #import the BMReachability.H header, add BMAddNetworkStatusObserver(self) in your code, and implement BMNetworkStatusProtocol.

typedef NS_ENUM(NSInteger, BMNetworkReachabilityStatus) {
    BMNetworkReachabilityStatusUnknown          = -1,
    BMNetworkReachabilityStatusNotReachable     = 0,
    BMNetworkReachabilityStatusReachableViaWWAN = 1,
    BMNetworkReachabilityStatusReachableViaWiFi = 2,
    BMNetworkReachabilityStatusReachableVia2G   = 3,
    BMNetworkReachabilityStatusReachableVia3G   = 4,
    BMNetworkReachabilityStatusReachableVia4G   = 5,
};

Example:

- (void)dealloc{
BMRemoveNetworkStatusObserver(self);
}

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.
[self button];
BMAddNetworkStatusObserver(self);
}

- (void)networkStatusDidChangedFromStatus:(BMNetworkReachabilityStatus)fromStatus
                                 toStatus:(BMNetworkReachabilityStatus)toStatus{

      NSLog(@"*****************************************");
      if (fromStatus != toStatus) { 
        NSLog(@"========状态改变了啊=========");
      }

      NSLog(@"fromStatus:  %@   toStatus: %@",@(fromStatus),@(toStatus));

      NSString  *statusStr = [[BMEnvObserverCenterNetworkStatus defaultCenter] currentNetWorkStatusString];
      NSLog(@"当前网络状态为: %@",statusStr);

}

Warning: You must remove Network Status Observer

4. QA
欢迎交流，在使用中遇到问题，可以给留言，当然最好自己试着修改，有好的建议，也希望给留言，或者新浪微博联系我
新浪微博：http://weibo.com/rubbishpicker

5. Licenses

All source code is licensed under the MIT License.
