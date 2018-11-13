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

