//
//  YYNetwork.m
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import "YYNetwork.h"
#import "AFNetworking.h"

@interface YYNetwork ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation YYNetwork

__strong static YYNetwork  *_singleManger = nil;
+ (YYNetwork *)getInstance {
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _singleManger = [[YYNetwork alloc] init];
    });
    return _singleManger;
}

#pragma mark - getter
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",nil];
    }
    return _manager;
}

#pragma mark - Public
- (void)getHTTPPath:(NSString *)apiPath response:(ResponseBlock)response {
    [self.manager GET:apiPath parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        response(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        response(nil, error);
    }];
}

@end
