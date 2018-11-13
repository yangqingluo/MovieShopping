//
//  YYBaseSubTableVC.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYBaseViewController.h"
#import "MJRefresh.h"

@interface YYBaseSubTableVC : YYBaseViewController<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithStyle:(UITableViewStyle)style;
- (void)bringTableViewUnderNavigation:(BOOL)under;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSString *dateKey;
@property (nonatomic, assign) NSInteger indextag;

- (void)updateTableViewHeader;
- (void)updateTableViewFooter;
- (void)beginRefreshing;
- (void)endRefreshing;
- (void)updateSubviews;
- (void)loadFirstPageData;
- (void)loadMoreData;
- (void)pullBaseListData:(BOOL)isReset;

- (void)becomeListed;
- (void)becomeUnListed;

@end
