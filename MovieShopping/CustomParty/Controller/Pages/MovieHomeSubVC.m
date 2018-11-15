//
//  MovieHomeSubVC.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "MovieHomeSubVC.h"
#import "CWCarousel.h"
#import "UIView+KGViewExtend.h"
#import "MoreHotShowCell.h"
#import "MoreSoonShowCell.h"
#import "YYPublic.h"
#import "FilmDetailVC.h"
#import "FilmSelectCinemaVC.h"

static NSString *adCellID = @"adCell";

@interface MovieHomeSubVC ()<CWCarouselDatasource, CWCarouselDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) UIView *topADView;
@property (nonatomic, strong) NSArray *hotArray;
@property (nonatomic, strong) NSArray *soonArray;

@end

@implementation MovieHomeSubVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.carousel controllerWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.carousel controllerWillDisAppear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildHeader];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
}

- (void)buildHeader {
    CATransition *tr = [CATransition animation];
    tr.type = @"cube";
    tr.subtype = kCATransitionFromRight;
    tr.duration = 0.25;
    [self.topADView.layer addAnimation:tr forKey:nil];
    
    if(self.carousel) {
        [self.carousel releaseTimer];
        [self.carousel removeFromSuperview];
        self.carousel = nil;
    }
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_Normal];
    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:CGRectZero
                                                    delegate:self
                                                  datasource:self
                                                  flowLayout:flowLayout];
    carousel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topADView addSubview:carousel];
    NSDictionary *dic = @{@"view" : carousel};
    [self.topADView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                           options:kNilOptions
                                                                           metrics:nil
                                                                             views:dic]];
    [self.topADView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                           options:kNilOptions
                                                                           metrics:nil
                                                                             views:dic]];
    
    
    carousel.isAuto = YES;
    carousel.autoTimInterval = 2;
    carousel.endless = YES;
    carousel.backgroundColor = [UIColor clearColor];
    [carousel registerViewClass:[UICollectionViewCell class] identifier:adCellID];
    [carousel freshCarousel];
    self.carousel = carousel;
    
    [self.headerView addSubview:self.topADView];
    self.headerView.height = self.topADView.bottom;
    self.tableView.tableHeaderView = self.headerView;
}

- (void)cellHeaderAllBtnAction:(UIButton *)button {
    NSLog(@"%ld", (long)button.tag);
}

#pragma mark - Networking
- (void)loadData {
    [self showHudInView:self.view hint:nil];
    __weak typeof(self) weakSelf = self;
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //3.添加请求
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [[YYNetwork getInstance] POST:@16 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            dispatch_group_leave(group);
            if (error) {

            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    weakSelf.hotArray = result.data.items;
                }
            }
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [[YYNetwork getInstance] POST:@17 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            dispatch_group_leave(group);
            if (error) {

            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    weakSelf.soonArray = result.data.items;
                }
            }
        }];
    });
    
    //4.队列组所有请求完成回调刷新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self hideHud];
        [self.tableView reloadData];
    });
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    }
    return _headerView;
}

- (UIView *)topADView {
    if(!_topADView) {
        _topADView = [[UIView alloc] initWithFrame:CGRectMake(0, YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT, CGRectGetWidth(self.view.frame), 160)];
    }
    return _topADView;
}

#pragma mark -CWCarouselDatasource, CWCarouselDelegate
- (NSInteger)numbersForCarousel {
    return 5;
}

- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index {
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:adCellID forIndexPath:indexPath];
    NSInteger kViewTag = 666;
    UIImageView *imgView = [cell.contentView viewWithTag:kViewTag];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(YYEdgeMiddle, YYEdge, cell.contentView.bounds.size.width - 2 * YYEdgeMiddle, cell.contentView.bounds.size.height - 2 * YYEdge)];
        imgView.tag = kViewTag;
        [cell.contentView addSubview:imgView];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 8;
    }
    
    NSString *name = [NSString stringWithFormat:@"ad_%02ld.jpg", index + 1];
    UIImage *img = [UIImage imageNamed:name];
    if(!img) {
        NSLog(@"%@", name);
    }
    [imgView setImage:img];
    return cell;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [YYCellHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YYCellHeaderView *view = [YYCellHeaderView new];
    view.moreBtn.tag = section;
    [view.moreBtn addTarget:self action:@selector(cellHeaderAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    switch (section) {
        case 0: {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = view.bounds;
            maskLayer.path = maskPath.CGPath;
            view.layer.mask = maskLayer;
            view.headerLabel.text = @"正在热映";
            return view;
        }
        case 1:
            view.topLine.hidden = NO;
            view.headerLabel.text = @"即将上映";
            return view;
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"cell_hot";
        MoreHotShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[MoreHotShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.dataList = self.hotArray;
        return cell;
    }
    else if (indexPath.section == 1) {
        static NSString *cellID = @"cell_soon";
        MoreSoonShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[MoreSoonShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.dataList = self.soonArray;
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - UIResponder+Router
- (void)routerEventWithName:(NSString *)eventName from:(id)fromObject userInfo:(NSObject *)userInfo {
    if ([eventName isEqualToString:Event_HotShowCellButtonClicked]) {
        NSInteger index = [(NSNumber *)userInfo integerValue];
        FilmSelectCinemaVC *vc = [FilmSelectCinemaVC new];
        vc.sourceData = self.hotArray[index];
        [[YYPublic getInstance].mainNav pushViewController:vc animated:YES];
    }
    else if ([eventName isEqualToString:Event_MoreCellItemSelected]) {
        NSIndexPath *indexPath = (NSIndexPath *)userInfo;
        FilmDetailVC *vc = [FilmDetailVC new];
        if ([fromObject isKindOfClass:[MoreHotShowCell class]]) {
            vc.sourceData = self.hotArray[indexPath.row];
        }
        else {
            vc.sourceData = self.soonArray[indexPath.row];
        }
        [[YYPublic getInstance].mainNav pushViewController:vc animated:YES];
    }
}

@end
