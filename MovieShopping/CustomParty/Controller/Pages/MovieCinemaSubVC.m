//
//  MovieCinemaSubVC.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "MovieCinemaSubVC.h"
#import "JSDropDownMenu.h"
#import "CinemaCell.h"
#import "CinemaSelectFilmVC.h"
#import "YYPublic.h"

@interface MovieCinemaSubVC ()<JSDropDownMenuDataSource, JSDropDownMenuDelegate> {
    
    NSArray *_data1;
    NSArray *_data2;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) JSDropDownMenu *menu;

@end

@implementation MovieCinemaSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data1 = @[@"不限区域", @"成华区", @"青羊区", @"锦江区", @"武侯区", @"金牛区", @"高新区", @"天府新区", @"双流区"];
    _data2 = @[@"距离最近", @"价格最低"];
    
    _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, YY_TOP_HEIGHT) andHeight: 40];
    _menu.indicatorColor = YYDeepGrayColor;
    _menu.separatorColor = YYSeparatorColor;
    _menu.textColor = YYTextColor;
    _menu.dataSource = self;
    _menu.delegate = self;
    _menu.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_menu];
    
    self.tableView.frame = CGRectMake(0, _menu.bottom, self.view.width, self.view.height - _menu.bottom);
    self.tableView.tableHeaderView = self.headerView;
    [self updateTableViewHeader];
    [self beginRefreshing];
}

#pragma mark - Networking
- (void)pullBaseListData:(BOOL)isReset {
    [self showHudInView:self.view hint:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [[YYNetwork getInstance] POST:@9 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
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

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        CGFloat width = CGRectGetWidth(self.view.frame);
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, (402.0 / 1125.0) * width)];
        _headerView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"yy_banner"].CGImage);
    }
    return _headerView;
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
    if (column == 0){
        return _data1.count;
    } else if (column == 1){
        return _data2.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            if (_currentData1Index == 0) {
                return @"区域";
            }
            return _data1[_currentData1Index];
            break;
        case 1: return _data2[_currentData2Index];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column==0) {
        
        return _data1[indexPath.row];
        
    } else {
        return _data2[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    if (indexPath.column == 0) {
        _currentData1Index = indexPath.row;
    } else {
        _currentData2Index = indexPath.row;
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_cinema";
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSString *nibName = NSStringFromClass([CinemaCell class]);
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:ID];
        cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = self.dataList[indexPath.row];
    cell.nameLabel.text = dic[@"cinema_name"];
    cell.addressLabel.text = dic[@"address"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元", dic[@"price"] ? dic[@"price"] : @""];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@km", dic[@"distance"] ? dic[@"distance"] : @""];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CinemaSelectFilmVC *vc = [CinemaSelectFilmVC new];
    vc.sourceData = self.dataList[indexPath.row];
    [[YYPublic getInstance].mainNav pushViewController:vc animated:YES];
}

@end
