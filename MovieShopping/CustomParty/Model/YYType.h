//
//  YYType.h
//  MovieShopping
//
//  Created by naver on 2018/11/13.
//  Copyright © 2018 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYType : NSObject

@property (nonatomic, copy) NSString *ID;

@end

@interface YYCity: YYType

@property (nonatomic, copy) NSString *city_code;//城市编码
@property (nonatomic, copy) NSString *pin_yin;//拼音
@property (nonatomic, copy) NSString *region_name;//城市名

@end

@interface YYData: NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger total;

@end

@interface YYResponse : NSObject

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) YYData *data;

@end

@interface YYSectionSeat : NSObject

@property (nonatomic, copy) NSString *extId;//座位id
@property (nonatomic, copy) NSString *name;//座位名称
@property (nonatomic, copy) NSString *rowName;//行名称
@property (nonatomic, assign) NSInteger status;//座位状态 1可售 0不可售 -1删除（非法）
@property (nonatomic, assign) NSInteger flag;//座位标识 0普通 1情侣座左 2情侣座右
@property (nonatomic, assign) NSInteger column;//列
@property (nonatomic, assign) NSInteger row;//行
@property (nonatomic, assign) NSInteger topPx;
@property (nonatomic, assign) NSInteger leftPx;

@end

@interface YYSection : NSObject

@property (nonatomic, assign) NSInteger maxLeftPx;
@property (nonatomic, assign) NSInteger minLeftPx;
@property (nonatomic, assign) NSInteger maxTopPx;
@property (nonatomic, assign) NSInteger minTopPx;
@property (nonatomic, assign) NSInteger maxColumn;
@property (nonatomic, assign) NSInteger minColumn;
@property (nonatomic, assign) NSInteger maxRow;
@property (nonatomic, assign) NSInteger minRow;
@property (nonatomic, assign) BOOL regular;//true使用行列 false使用坐标
@property (nonatomic, assign) NSInteger soldCount;//已售座位数
@property (nonatomic, assign) NSInteger maxCanBuy;//可锁座的最大数
@property (nonatomic, assign) NSInteger seatCount;//座位总数量
@property (nonatomic, copy) NSString *tipMessage;//影院强制弹窗须知
@property (nonatomic, copy) NSString *hall_name;
@property (nonatomic, copy) NSArray<YYSectionSeat *> *seats;

@end

