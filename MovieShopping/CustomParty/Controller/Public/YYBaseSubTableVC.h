//
//  YYBaseSubTableVC.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYBaseViewController.h"

@interface YYBaseSubTableVC : YYBaseViewController<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithStyle:(UITableViewStyle)style;
- (void)bringTableViewUnderNavigation:(BOOL)under;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end
