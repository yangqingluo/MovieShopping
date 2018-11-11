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

@interface MovieHomeSubVC ()<CWCarouselDatasource, CWCarouselDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) UIView *topADView;

@end

@implementation MovieHomeSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    CATransition *tr = [CATransition animation];
    tr.type = @"cube";
    tr.subtype = kCATransitionFromRight;
    tr.duration = 0.25;
    [self.topADView.layer addAnimation:tr forKey:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if(self.carousel) {
        [self.carousel releaseTimer];
        [self.carousel removeFromSuperview];
        self.carousel = nil;
    }
    
    self.topADView.backgroundColor = [UIColor whiteColor];
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_Normal];
    
    //    /*
    //     使用frame创建视图
    //     */
    //    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:self.topADView.bounds
    //                                                    delegate:self
    //                                                  datasource:self
    //                                                  flowLayout:flowLayout];
    //    [self.topADView addSubview:carousel];
    
    // 使用layout创建视图(使用masonry 或者 系统api)
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
    carousel.backgroundColor = [UIColor whiteColor];
    [carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId"];
    [carousel freshCarousel];
    self.carousel = carousel;
    
    self.headerView.height = self.topADView.bottom;
    [self.headerView addSubview:self.topADView];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - getter
- (UIView *)topADView {
    if(!_topADView) {
        self.topADView = [[UIView alloc] initWithFrame:CGRectMake(0, YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT, CGRectGetWidth(self.view.frame), 160)];
    }
    return _topADView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    }
    return _headerView;
}

#pragma mark -CWCarouselDatasource, CWCarouselDelegate
- (NSInteger)numbersForCarousel {
    return 5;
}

- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index {
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSInteger kViewTag = 666;
    UIImageView *imgView = [cell.contentView viewWithTag:kViewTag];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, cell.contentView.bounds.size.width - 2 * 20, cell.contentView.bounds.size.height)];
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
