//
//  GF_LocateHeaderView.h
//  CityListDemo
//
//  Created by GaoFei on 16/3/19.
//  Copyright © 2016年 YF_S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GF_LocateHeaderView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSString* cityName;//当前定位城市

@property (nonatomic,copy) void(^selectCity)(NSString* city);
-(instancetype)initWithSource:(NSMutableArray*)array;


@end
