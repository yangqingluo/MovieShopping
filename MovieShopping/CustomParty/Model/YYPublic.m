//
//  YYPublic.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYPublic.h"

@implementation YYPublic

__strong static YYPublic  *_singleManger = nil;
+ (YYPublic *)getInstance {
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _singleManger = [[YYPublic alloc] init];
    });
    return _singleManger;
}

- (instancetype)init {
    if (_singleManger) {
        return _singleManger;
    }
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
