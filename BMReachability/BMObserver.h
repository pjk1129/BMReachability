//
//  BMObserver.h
//  BMReachabilityDemo
//
//  Created by baidu on 15/8/7.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMObserver : NSObject

@property (nonatomic,weak) id observer;

+ (id)createWithObejct:(id)obejct;
- (id)initWithObject:(id)object;

- (void)noticeOberver:(SEL)selector;
- (void)noticeOberver:(SEL)selector withObject:(id)object;
- (void)noticeOberver:(SEL)selector withObject:(id)object1 withObject:(id)object2;

@end
