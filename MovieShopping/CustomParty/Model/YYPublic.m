//
//  YYPublic.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYPublic.h"
#import "MJExtension.h"

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

#pragma mark - getter

YYResponse *APIData(NSNumber *number) {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"api_%@.txt", number] ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!dic) {
        NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        dic = [jsonString mj_keyValues];
    }
    return [YYResponse mj_objectWithKeyValues:dic];
}

@end
