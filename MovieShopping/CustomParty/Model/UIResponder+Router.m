//
//  UIResponder+Router.m
//
//  Created by yangqingluo on 2017/5/3.
//  Copyright © 2017年 yangqingluo. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo{
    [self routerEventWithName:eventName from:nil userInfo:userInfo];
}

- (void)routerEventWithName:(NSString *)eventName from:(id)fromObject userInfo:(NSObject *)userInfo {
    [[self nextResponder] routerEventWithName:eventName from:fromObject userInfo:userInfo];
}

@end
