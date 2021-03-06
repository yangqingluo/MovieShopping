//
//  CinemaSelectFilmVC.m
//  MovieShopping
//
//  Created by naver on 2018/11/13.
//  Copyright © 2018 yang. All rights reserved.
//

#import "CinemaSelectFilmVC.h"
#import "CinemaForFilmCell.h"
#import "SGPageView.h"
#import "FilmSectionCell.h"
#import "SeatViewController.h"

@interface CinemaSelectFilmVC ()<YYMovieBrowserDelegate, SGPageTitleViewDelegate> {
    NSInteger filmIndex;
}

@property (nonatomic, copy) NSArray *filmList;
@property (nonatomic, copy) NSArray *dateList;
@property (nonatomic, copy) NSArray *scheduleList;
@property (nonatomic, strong) CinemaForFilmCell *infoCell;
@property (nonatomic, strong) SGPageTitleView *dateView;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation CinemaSelectFilmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sourceData[@"cinema_name"];
    [self bringTableViewUnderNavigation:YES];
    self.tableView.tableHeaderView = self.headerView;
    [self updateTableViewHeader];
    [self beginRefreshing];
}

- (void)updateBrowsers {
    if (self.filmList.count) {
        self.infoCell.browser = [[YYMovieBrowser alloc] initWithFrame:CGRectMake(0, 75, self.view.width, 125) movies:self.filmList currentIndex:0];
        [self.infoCell.contentView addSubview:self.infoCell.browser];
        self.infoCell.browser.delegate = self;
        [self movieBrowser:self.infoCell.browser didChangeItemAtIndex:0];
    }
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
        self.dateView = [[SGPageTitleView alloc] initWithFrame:CGRectMake(0, self.infoCell.bottom, self.view.width, self.headerView.height - self.infoCell.bottom) delegate:self titleNames:m_array];
        [self.headerView addSubview:self.dateView];
    }
}

- (void)cellBuyBtnAction:(UIButton *)button {
    
}

#pragma mark - Networking
- (void)pullBaseListData:(BOOL)isReset {
    [self showHudInView:self.view hint:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [[YYNetwork getInstance] POST:@10 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            if (error) {
                
            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    self.filmList = result.data.items;
                }
                [weakSelf endRefreshing];
                [weakSelf updateBrowsers];
            }
        }];
    });
}

- (void)loadDateListForFilm:(NSDictionary *)dic {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [[YYNetwork getInstance] POST:@11 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            if (error) {
                
            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    self.dateList = result.data.items;
                }
                [weakSelf endRefreshing];
                [weakSelf updateDateView];
            }
        }];
    });
}

- (void)loadSectionListForFilm:(NSDictionary *)film date:(NSDictionary *)date {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [[YYNetwork getInstance] POST:@12 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            if (error) {
                
            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    self.scheduleList = result.data.items;
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
        NSString *nibName = NSStringFromClass([CinemaForFilmCell class]);
        self.infoCell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
        self.infoCell.width = self.view.width;
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.infoCell.height + 50)];
        [_headerView addSubview:self.infoCell];
        [_headerView addSubview:NewSeparatorLine(CGRectMake(0, self.infoCell.bottom, _headerView.width, 0.5))];
        NSDictionary *dic = self.sourceData;
        self.infoCell.nameLabel.text = dic[@"cinema_name"];
        self.infoCell.addressLabel.text = dic[@"address"];
    }
    return _headerView;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scheduleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_cinema_film_section";
    FilmSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSString *nibName = NSStringFromClass([FilmSectionCell class]);
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:ID];
        cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
    }
    NSDictionary *dic = self.scheduleList[indexPath.row];
    cell.startTimeLabel.text = [dic[@"show_time"] substringFromIndex:11];
    cell.endTimeLabel.text = [NSString stringWithFormat:@"%@散场", [dic[@"close_time"] substringFromIndex:11]];
    cell.versionLabel.text = dic[@"show_version"];
    cell.hallLabel.text = dic[@"hall_name"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元", dic[@"price"] ? dic[@"price"] : @""];
    cell.buyBtn.tag = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SeatViewController *vc = [SeatViewController new];
    vc.sourceData = self.sourceData;
    vc.filmData = self.filmList[filmIndex];
    vc.scheduleData = self.scheduleList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YYMovieBrowserDelegate
- (void)movieBrowser:(YYMovieBrowser *)browser didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)movieBrowser:(YYMovieBrowser *)browser didChangeItemAtIndex:(NSInteger)index {
    filmIndex = index;
    NSDictionary *dic = self.filmList[index];
    self.infoCell.filmNameLabel.text = dic[@"show_name"];
    self.infoCell.filmInfoLabel.text = [NSString stringWithFormat:@"%@分钟|%@|%@", dic[@"duration"], @"剧情", dic[@"leading_role"]];
    [self loadDateListForFilm:dic];
}

//static NSInteger _lastIndex = -1;
//- (void)movieBrowser:(YYMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index {
//    if (_lastIndex != index) {
//
//    }
//    _lastIndex = index;
//}

#pragma mark - SGPageTitleViewDelegate
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    self.scheduleList = @[];
    [self.tableView reloadData];
    [self loadSectionListForFilm:self.filmList[filmIndex] date:self.dateList[selectedIndex]];
}

@end
