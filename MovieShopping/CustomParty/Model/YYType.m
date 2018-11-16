//
//  YYType.m
//  MovieShopping
//
//  Created by naver on 2018/11/13.
//  Copyright © 2018 yang. All rights reserved.
//

#import "YYType.h"

@implementation YYType

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

@end

@implementation YYCity


@end

@implementation YYData

@end

@implementation YYResponse

@end


@implementation YYSectionSeat

@end

@implementation YYSection

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"seats" : @"YYSectionSeat"};
}

@end
