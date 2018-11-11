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

static NSString *adCellID = @"adCell";

@interface MovieHomeSubVC ()<CWCarouselDatasource, CWCarouselDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) UIView *topADView;
@property (nonatomic, strong) MoreHotShowCell *hotShowView;
@property (nonatomic, strong) MoreSoonShowCell *soonShowView;

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
    
    [self buildHotShows];
    [self buildSoonShows];
    
    self.headerView.height = self.soonShowView.bottom;
    self.tableView.tableHeaderView = self.headerView;
}

- (void)buildHotShows {
    NSArray *m_array = [filmString mj_JSONObject][@"movieList"];
    
    self.hotShowView = [MoreHotShowCell new];
    self.hotShowView.dataList = m_array;
    self.hotShowView.top = self.topADView.bottom;
    [self.headerView addSubview:self.hotShowView];
}

- (void)buildSoonShows {
    NSArray *m_array = [filmString mj_JSONObject][@"movieList"];
    
    self.soonShowView = [MoreSoonShowCell new];
    self.soonShowView.dataList = m_array;
    self.soonShowView.top = self.hotShowView.bottom;
    [self.headerView addSubview:self.soonShowView];
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
        _headerView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"ad_01.jpg"].CGImage);
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

#pragma mark - UIResponder+Router
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo {
    if ([eventName isEqualToString:Event_HotShowSellButtonClicked]) {
        NSInteger index = [(NSNumber *)userInfo integerValue];
        NSLog(@"%ld", (long)index);
    }
    else if ([eventName isEqualToString:Event_HotShowSellSelected]) {
        NSIndexPath *indexPath = (NSIndexPath *)userInfo;
        NSLog(@"cellSelected: %ld", (long)indexPath.row);
        FilmDetailVC *vc = [FilmDetailVC new];
        vc.sourceData = self.hotShowView.dataList[indexPath.row];
        [[YYPublic getInstance].mainNav pushViewController:vc animated:YES];
    }
}

@end
