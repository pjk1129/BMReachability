//
//  ViewController.m
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "ViewController.h"
#import "BMReachability.H"

@interface ViewController ()<BMNetworkStatusProtocol>

@property (nonatomic, strong) UIButton  *button;
@end

@implementation ViewController

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

- (void)buttonDidTouched{
    NSString  *statusStr = [[BMEnvObserverCenterNetworkStatus defaultCenter] currentNetWorkStatusString];
    NSLog(@"statusStr: %@",statusStr);
}

#pragma mark - getter
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.frame = CGRectMake(40, 100, 60, 30);
        [_button setTitle:@"当前网络" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonDidTouched) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
    return _button;
}

@end
