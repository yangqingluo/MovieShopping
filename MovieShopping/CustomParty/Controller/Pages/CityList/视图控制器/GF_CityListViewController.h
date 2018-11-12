//
//  GF_CityListViewController.h
//  CityListDemo
//
//  Created by GaoFei on 16/3/19.
//  Copyright © 2016年 YF_S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYBaseSubTableVC.h"

typedef void(^changeCityName)(NSString *cityName);

@interface GF_CityListViewController : YYBaseSubTableVC


//block
-(void)changeCityName:(changeCityName)block;

@property (nonatomic,copy) changeCityName block;


@end
