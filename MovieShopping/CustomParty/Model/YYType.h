//
//  YYType.h
//  MovieShopping
//
//  Created by naver on 2018/11/13.
//  Copyright © 2018 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYType : NSObject

@end

@interface YYData: NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSNumber *total;

@end

@interface YYResponse : NSObject

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) YYData *data;

@end

