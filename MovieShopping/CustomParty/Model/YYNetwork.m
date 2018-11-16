//
//  YYNetwork.m
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import "YYNetwork.h"
#import "AFNetworking.h"
#import "YYType.h"
#import "MJExtension.h"

@interface YYNetwork ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSArray *apiArray;

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
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [_manager.requestSerializer setTimeoutInterval:1.0];
        NSString *token = @"";
        if (token) {
            [_manager.requestSerializer setValue:[NSString stringWithFormat:@" HAuth %@", token] forHTTPHeaderField:@"Authorization"];
        }
    }
    return _manager;
}

- (NSArray *)apiArray {
    if (!_apiArray) {
        _apiArray = @[@"/movie/detail",
                      @"/movie/detail/getTrailerList",
                      @"/movie/detail/getAllleadingRole",
                      @"/evaluation/comment",//4评论
                      @"/evaluation/favor",//5点赞/取消点赞
                      @"/evaluation/reply",
                      @"/evaluation/replyAppPage",
                      @"/evaluation/wantsee",
                      @"/cinema/findCinemaList",
                      @"/cinema/findMovieByCinemaId",//10查询影院正在上映电影
                      @"/cinema/findMovieShowData",
                      @"/cinema/findScheduleByMovieId",
                      @"/findCinema",
                      @"/findMovie",
                      @"/getFilm/taopiaopiaoBanner",//15获取获取首页Banner图
                      @"/getFilm/getHotFilmList",
                      @"/getFilm/getSoonFilmList",
                      @"/film/regions",
                      @"/film/showdates",
                      @"/film/cinemas",//20查询电影影院
                      @"/schedule/seat",
                      @"/schedule/lockseat",
                      @"/getFilm/getCityList",
                      @"/getFilm/getCityName",
                      ];
    }
    return _apiArray;
}

#define API_URL @"http://192.168.2.102"
NSString *urlStringWithPath(NSString *path) {
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
//    return [[NSString stringWithFormat:@"%@%@", API_URL, path] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return [NSString stringWithFormat:@"%@%@", API_URL, path];
}

NSDictionary *APIData(NSNumber *number) {
//    if ([number isEqual: @21]) {
//        number = @211;
//    }
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"api_%@.txt", number] ofType:nil];
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return [jsonString mj_JSONObject];
}

#pragma mark - Public
- (void)getHTTPPath:(NSString *)apiPath response:(ResponseBlock)response {
    [self.manager GET:apiPath parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        response(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        response(nil, error);
    }];
}

- (void)GET:(NSNumber *)apiNumer parameters:(NSDictionary *)parms headers:(NSDictionary *)headers response:(ResponseBlock)response {
    NSInteger index = [apiNumer integerValue];
    if (index > 0 && index < self.apiArray.count) {
        [self.manager GET:urlStringWithPath(self.apiArray[index - 1]) parameters:parms headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            response(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            response(nil, error);
            response(APIData(apiNumer), nil);
        }];
    }
    else {
        response(nil, [NSError errorWithDomain:@"com.movie" code:404 userInfo:@{@"msg":@"invalid apiNumber"}]);
    }
}

- (void)POST:(NSNumber *)apiNumer parameters:(NSDictionary *)parms headers:(NSDictionary *)headers response:(ResponseBlock)response {
    NSInteger index = [apiNumer integerValue];
    if (index > 0 && index < self.apiArray.count) {
        [self.manager POST:urlStringWithPath(self.apiArray[index - 1]) parameters:parms headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            response(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            response(nil, error);
            response(APIData(apiNumer), nil);
        }];
    }
    else {
        response(nil, [NSError errorWithDomain:@"com.movie" code:404 userInfo:@{@"msg":@"invalid apiNumber"}]);
    }
}

@end
