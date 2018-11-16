//
//  FilmToSelectCinemaVC.m
//  MovieShopping
//
//  Created by naver on 2018/11/13.
//  Copyright © 2018 yang. All rights reserved.
//

#import "FilmSelectCinemaVC.h"
#import "GF_CityListViewController.h"
#import "SGPageView.h"
#import "JSDropDownMenu.h"
#import "CinemaCell.h"
#import "CinemaSectionCell.h"
#import "SeatViewController.h"

@interface FilmSelectCinemaVC ()<SGPageTitleViewDelegate,JSDropDownMenuDataSource, JSDropDownMenuDelegate> {
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger dateIndex;
}

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) JSDropDownMenu *menu;
@property (nonatomic, copy) NSArray *menuData1;
@property (nonatomic, copy) NSArray *menuData2;

@property (nonatomic, strong) SGPageTitleView *dateView;
@property (nonatomic, copy) NSArray *dateList;

@end

@implementation FilmSelectCinemaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sourceData[@"show_name"];
    self.navigationItem.leftBarButtonItems = @[self.navigationItem.leftBarButtonItem, [[UIBarButtonItem alloc] initWithTitle:[YYPublic getInstance].city.region_name style:UIBarButtonItemStylePlain target:self action:@selector(cityBtnAction)]];
    [self.view addSubview:self.menu];
    
    [self loadMenuList];
    self.tableView.frame = CGRectMake(0, self.menu.bottom, self.view.width, self.view.height - self.menu.bottom);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    [self updateTableViewHeader];
    [self loadDateList];
}

- (void)cityBtnAction {
    GF_CityListViewController *cityListVC = [GF_CityListViewController new];
    [self.navigationController pushViewController:cityListVC animated:YES];
}

- (void)updateDateView {
    if (self.dateList.count) {
        if (self.dateView) {
            [self.dateView removeFromSuperview];
        }
        NSMutableArray *m_array = [NSMutableArray arrayWithCapacity:self.dateList.count];
        for (NSDictionary *item in self.dateList) {
            [m_array addObject:item[@"show_date"]];
        }
        self.dateView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(0, YY_TOP_HEIGHT, self.view.width, 40) delegate:self titleNames:m_array];
        [self.view addSubview:self.dateView];
    }
}

- (void)updateMenu {
    [self.menu reloadData];
}

#pragma mark - Networking
- (void)pullBaseListData:(BOOL)isReset {
    [self showHudInView:self.view hint:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [[YYNetwork getInstance] POST:@20 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            if (error) {
                
            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    if (isReset) {
                        [weakSelf.dataList removeAllObjects];
                    }
                    [weakSelf.dataList addObjectsFromArray:result.data.items];
                    if (result.data.total > self.dataList.count) {
                        [self updateTableViewFooter];
                    }
                    else {
                        self.tableView.mj_footer = nil;
                    }
                }
                [weakSelf endRefreshing];
                [weakSelf updateSubviews];
            }
        }];
    });
}

- (void)loadDateList {
    [self showHudInView:self.view hint:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [[YYNetwork getInstance] POST:@19 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            if (error) {
                
            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    weakSelf.dateList = result.data.items;
                }
                [weakSelf endRefreshing];
                [weakSelf updateDateView];
            }
        }];
    });
}

- (void)loadMenuList {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:0.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.menuData1 = @[@"不限区域", @"成华区", @"青羊区", @"锦江区", @"武侯区", @"金牛区", @"高新区", @"天府新区", @"双流区"];
            self.menuData2 = @[@"距离最近", @"价格最低"];
            [self updateMenu];
        });
    });
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        CGFloat width = CGRectGetWidth(self.view.frame);
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, (402.0 / 1125.0) * width)];
        _headerView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"yy_banner"].CGImage);
    }
    return _headerView;
}

- (JSDropDownMenu *)menu {
    if (!_menu) {
        _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, YY_TOP_HEIGHT + 40) andHeight: 40];
        _menu.indicatorColor = YYDeepGrayColor;
        _menu.separatorColor = YYSeparatorColor;
        _menu.textColor = YYTextColor;
        _menu.dataSource = self;
        _menu.delegate = self;
        _menu.backgroundColor = [UIColor whiteColor];
    }
    return _menu;
}

#pragma mark - JSDropDownMenu
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    return 2;
}

- (BOOL)displayByCollectionViewInColumn:(NSInteger)column {
    return YES;
}

- (BOOL)haveRightTableViewInColumn:(NSInteger)column {
    return NO;
}

- (CGFloat)widthRatioOfLeftColumn:(NSInteger)column {
    return 1;
}

- (NSInteger)currentLeftSelectedRow:(NSInteger)column {
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    if (column == 0) {
        return self.menuData1.count;
    } else if (column == 1) {
        return self.menuData2.count;
    }
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column {
    switch (column) {
        case 0:
            if (_currentData1Index == 0) {
                return @"区域";
            }
            return self.menuData1[_currentData1Index];
            break;
        case 1: return self.menuData2[_currentData2Index];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.menuData1[indexPath.row];
    } else {
        return self.menuData2[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        _currentData1Index = indexPath.row;
    } else {
        _currentData2Index = indexPath.row;
    }
}

#pragma mark - SGPageTitleViewDelegate
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    dateIndex = selectedIndex;
    [self.dataList removeAllObjects];
    [self.tableView reloadData];
    [self pullBaseListData:YES];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, [self tableView:tableView heightForFooterInSection:section])];
    [view addSubview:NewSeparatorLine(CGRectMake(0, view.bottom - 0.5, view.width, 0.5))];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    }
    else {
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellID = @"cell_cinema";
        CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            NSString *nibName = NSStringFromClass([CinemaCell class]);
            [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellID];
            cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
        }
        cell.backgroundColor = [UIColor clearColor];
        NSDictionary *dic = self.dataList[indexPath.section];
        cell.nameLabel.text = dic[@"cinema_name"];
        cell.addressLabel.text = dic[@"address"];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@元", dic[@"min_price"] ? dic[@"min_price"] : @""];
        cell.distanceLabel.text = [NSString stringWithFormat:@"%@km", dic[@"distance"] ? dic[@"distance"] : @""];
        return cell;
    }
    else {
        static NSString *cellID = @"cell_cinema_section";
        CinemaSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CinemaSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dic = self.dataList[indexPath.section];
        cell.dataList = dic[@"play_desc_list"];
        cell.tag = indexPath.section;
        return cell;
    }
    
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UIResponder+Router
- (void)routerEventWithName:(NSString *)eventName from:(id)fromObject userInfo:(NSObject *)userInfo {
    if ([eventName isEqualToString:Event_MoreCellItemSelected]) {
        NSIndexPath *indexPath = (NSIndexPath *)userInfo;
        SeatViewController *vc = [SeatViewController new];
        vc.sourceData = self.dataList[indexPath.section];
        vc.filmData = self.sourceData;
        vc.scheduleData = vc.sourceData[@"play_desc_list"][indexPath.row];
        vc.dateData = self.dateList[dateIndex];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
