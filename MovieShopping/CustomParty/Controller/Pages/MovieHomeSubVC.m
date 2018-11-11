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

static NSString *adCellID = @"adCell";

@interface MovieHomeSubVC ()<CWCarouselDatasource, CWCarouselDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) UIView *topADView;
@property (nonatomic, strong) MoreHotShowCell *hotShowView;
@property (nonatomic, strong) YYMoreCell *soonShowView;

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
    self.view.backgroundColor = [UIColor whiteColor];
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
    NSString *jsonString = @"{\"movieList\":[{\"Id\":42964,\"BackgroundPicture\":\"http://p7.qhmsg.com/t01de9a61e79f600505.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"毒液：致命守护者\",\"OpenDay\":\"2018-11-09\"}]}";
    NSArray *m_array = [jsonString mj_JSONObject][@"movieList"];
    NSLog(@"%@", m_array);
    
    self.hotShowView = [MoreHotShowCell new];
    self.hotShowView.top = self.topADView.bottom;
    [self.headerView addSubview:self.hotShowView];
}

- (void)buildSoonShows {
    NSString *jsonString = @"{\"movieList\":[{\"Id\":42964,\"BackgroundPicture\":\"http://p7.qhmsg.com/t01de9a61e79f600505.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"毒液：致命守护者\",\"OpenDay\":\"2018-11-09\"}]}";
    NSArray *m_array = [jsonString mj_JSONObject][@"movieList"];
    NSLog(@"%@", m_array);
    
    self.soonShowView = [YYMoreCell new];
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

@end
