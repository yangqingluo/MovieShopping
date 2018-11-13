//
//  YYBaseSubTableVC.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYBaseSubTableVC.h"

@interface YYBaseSubTableVC ()

@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation YYBaseSubTableVC

- (instancetype)init{
    self = [super init];
    if (self) {
        _style = UITableViewStyleGrouped;
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)bringTableViewUnderNavigation:(BOOL)under {
    if (under) {
        self.tableView.frame = CGRectMake(0, YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT, self.view.width, self.view.height - (YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT));
    }
    else {
        self.tableView.frame = self.view.bounds;
    }
}

- (void)loadFirstPageData {
    [self pullBaseListData:YES];
}

- (void)loadMoreData {
    [self pullBaseListData:NO];
}

- (void)pullBaseListData:(BOOL)isReset {
    
}

- (void)updateTableViewHeader {
    typeof(self) __weak weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadFirstPageData];
    }];
}

- (void)updateTableViewFooter {
    typeof(self) __weak weakself = self;
    if (!self.tableView.mj_footer) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadMoreData];
        }];
    }
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefreshing {
    //记录刷新时间
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.dateKey];
    [self hideHud];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateSubviews {
    [self.tableView reloadData];
}

#define YYRefreshTime               24 * 60 * 60//自动刷新间隔时间
- (void)becomeListed {
    NSDate *lastRefreshTime = [[NSUserDefaults standardUserDefaults] objectForKey:self.dateKey];
    if (!self.dataList.count || !lastRefreshTime || [lastRefreshTime timeIntervalSinceNow] < -YYRefreshTime) {
        [self beginRefreshing];
    }
}

- (void)becomeUnListed {
    
}

#pragma mark - getter
- (NSString *)dateKey{
    if (!_dateKey) {
        _dateKey = [NSString stringWithFormat:@"%@_dateKey_%d", [self class], (int)self.indextag];
    }
    return _dateKey;
}

#pragma mark - getter
- (UITableView *)tableView{
    if (_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_style];
        _tableView.separatorColor = YYSeparatorColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |  UIViewAutoresizingFlexibleBottomMargin;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
