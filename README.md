# BMReachability

## What's BMReachability?
### BMReachability是基于AFNetworking的Reachability类封装的监听网络状态变化的组件。
### 它在AF提供的无网络/wifi/蜂窝网络判断的基础上，增加了对2G/3G/4G网络的判断。
```objective-c
	typedef NS_ENUM(NSInteger, BMNetworkReachabilityStatus) {
    	BMNetworkReachabilityStatusUnknown          = -1,
    	BMNetworkReachabilityStatusNotReachable     = 0,
    	BMNetworkReachabilityStatusReachableViaWWAN = 1,
    	BMNetworkReachabilityStatusReachableViaWiFi = 2,
    	BMNetworkReachabilityStatusReachableVia2G   = 3,
    	BMNetworkReachabilityStatusReachableVia3G   = 4,
    	BMNetworkReachabilityStatusReachableVia4G   = 5,
	};
```

## Requirements
### 最低要求支持 iOS 7.0 版本

## How To Use？

### 1.在你的类中导入BMReachability.h头文件;  
### 2.增加BMAddNetworkStatusObserver(self)监听，并实现BMNetworkStatusProtocol;  
### 3.在监听对象销毁时请注意移除监听BMRemoveNetworkStatusObserver(self)

## Example:
```objective-c
	- (void)dealloc{
    	BMRemoveNetworkStatusObserver(self);
	}
	- (void)viewDidLoad {
   	 [super viewDidLoad];
   	 BMAddNetworkStatusObserver(self);
	}
	
	#pragma mark - BMNetworkStatusProtocol
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
```

### 特别提示: 你必须要在监听类销毁时调用BMRemoveNetworkStatusObserver(self);

## Author

iJecky <http://weibo.com/rubbishpicker>

## License

BMReachability is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
