//
//  YYNetwork.h
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

/**
 首页电影列表
 type=hot 类型
 offset : 数据开始位置
 limit : 偏移量
 */
#define API_MOVIE_LIST(type,offset,limit) [NSString stringWithFormat:@"https://m.maoyan.com/ajax/movieOnInfoList?type=%@&offset=%@&limit=%@",type,offset,limit]

/**
 热门搜索列表
 */
#define API_MOVIE_SEARCH_HOTLIST @"https://api.maoyan.com/mmdb/search/movie/hotmovie/list.json"

#define API_MOVIE_SEARCH(limit,keyword) [[NSString stringWithFormat:@"https://api.maoyan.com/mmdb/search/integrated/keyword/list.json?ci=%@&keyword=%@",limit,keyword]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

/**
 查询电影详情
 movieid : 电影id
 */
#define API_MOVIE_DETAIL(movieid) [NSString stringWithFormat:@"https://api.maoyan.com/mmdb/movie/v5/%@.json",movieid]

/**
 演员表
 movieid : 电影id
 */
#define API_MOVIE_PERFORMER(movieid) [NSString stringWithFormat:@"https://api.maoyan.com/mmdb/v6/movie/%@/celebrities.json",movieid]

/**
 票房情况
 movieid : 电影id
 */
#define API_MOVIE_BOXOFFICE(movieid) [NSString stringWithFormat:@"https://api.maoyan.com/mmdb/movie/%@/feature/v1/mbox.json",movieid]
/**
 查出电影详情(包含评论)
 movieid : 电影id
 */
#define API_MOVIE_DETAIL_AS_COMMENT(movieid) [NSString stringWithFormat:@"https://m.maoyan.com/movie/%@.json",movieid]

/**
 加载更多评论
 movieid : 电影id
 offset : 数据开始位置
 limit : 偏移量
 */
#define API_MOVIE_COMMENT(movieid,limit,offset) [NSString stringWithFormat:@"https://m.maoyan.com/comments.json?movieid=%@&limit=%@&offset=%@",movieid,limit,offset]

/**
 短评评论
 movieid : 电影id
 tag: 短评标签(详见短评标签API)
 offset : 数据开始位置
 limit : 偏移量
 */

#define API_MOVIE_COMMENT_SHOT(movieid,tag,limit,offset) [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/comments/movie/v2/%@.json?tag=%@&limit=%@&offset=%@",movieid,tag,limit,offset]


/**
 评论标签
 movieid : 电影id
 */
#define API_MOVIE_COMMENT_TAG(movieid) [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/comment/tag/movie/%@.json",movieid]

/**
 查出影院(会自动根据你的ip段加载出你本地的影院)
 */
#define API_CINEMA_LIST @"https://m.maoyan.com/ajax/cinemaList"

/**
 查询出影院详情
 cinemaid : 影院id
 movieid : 电影id
 */
#define API_CINEMA_DETAIL(cinemaid,movieid) [NSString stringWithFormat:@"http://m.maoyan.com/showtime/wrap.json?cinemaid=%@&movieid=%@",cinemaid,movieid]

/**
 选座
 showId : 影片演出id
 showDate : 演出时间
 */
#define API_SEATS_SHOW(showId,showDate) [NSString stringWithFormat:@"https://m.maoyan.com/show/seats?showId=%@&showDate=%@",showId,showDate]

#define HTTP_SUCCESS 200

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(id response, NSError *error);

@interface YYNetwork : NSObject

+ (YYNetwork *)getInstance;

- (void)getHTTPPath:(NSString *)apiPath response:(ResponseBlock)response;
- (void)GET:(NSNumber *)apiNumer parameters:(NSDictionary *)parms headers:(NSDictionary *)headers response:(ResponseBlock)response;
- (void)POST:(NSNumber *)apiNumer parameters:(NSDictionary *)parms headers:(NSDictionary *)headers response:(ResponseBlock)response;

@end
