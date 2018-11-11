//
//  YYSeat.h
//  MovieSeat
//
//  Created by naver on 2018/11/5.
//  Copyright © 2018 7kers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSeat : NSObject

@property (nonatomic, copy) NSString *columnId;
@property (nonatomic, copy) NSString *seatNo;
@property (nonatomic, copy) NSString *st;

@end

@interface YYSeats : NSObject

@property (nonatomic, strong) NSArray<YYSeat *> *columns;
@property (nonatomic, copy)   NSString *rowId;//座位行号
@property (nonatomic, strong) NSNumber *rowNum; //座位屏幕行，用于算座位frame

@end
