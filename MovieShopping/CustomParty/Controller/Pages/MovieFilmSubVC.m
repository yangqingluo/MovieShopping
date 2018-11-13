//
//  MovieFilmSubVC.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "MovieFilmSubVC.h"
#import "YYSlideSwitchView.h"
#import "FilmHotSubTableVC.h"
#import "FilmSoonSubTableVC.h"
#import "UIImage+Color.h"

@interface MovieFilmSubVC ()<YYSlideSwitchViewDelegate>

@property (strong, nonatomic) YYSlideSwitchView *slidePageView;
@property (strong, nonatomic) NSMutableArray *viewArray;

@end

@implementation MovieFilmSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slidePageView buildUI];
}

- (void)addViewController:(NSString *)title vc:(YYBaseViewController *)vc {
    [self.viewArray addObject:@{@"title" : title, @"VC":vc}];
}

#pragma mark - getter
- (YYSlideSwitchView *)slidePageView{
    if (!_slidePageView) {
        _slidePageView = [[YYSlideSwitchView alloc] initWithFrame:CGRectMake(0, YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT, self.view.width, self.view.height - (YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT)) withHeightOfTop: 40.0];
        _slidePageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        _slidePageView.delegate = self;
        _slidePageView.topScrollView.backgroundColor = [UIColor whiteColor];
        _slidePageView.tabItemNormalColor = YYTextColor;
        _slidePageView.tabItemSelectedColor = YYMainColor;
        _slidePageView.shadowImageView.backgroundColor = YYSeparatorColor;
        _slidePageView.rootScrollView.scrollEnabled = YES;
    }
    return _slidePageView;
}

- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray new];
        [self addViewController:@"正在热映" vc:[FilmHotSubTableVC new]];
        [self addViewController:@"即将上映" vc:[FilmSoonSubTableVC new]];
        [self.view addSubview:self.slidePageView];
    }
    return _viewArray;
}

#pragma mark - QCSlider
- (CGFloat)widthOfTab:(NSUInteger)index {
    return self.view.bounds.size.width / self.viewArray.count;
}
- (NSString *)titleOfTab:(NSUInteger)index {
    NSDictionary *dic = self.viewArray[index];
    return dic[@"title"];
}

- (NSUInteger)numberOfTab:(YYSlideSwitchView *)view {
    return self.viewArray.count;
}

- (UIImage *)normalImageNameOfTab:(NSUInteger)index {
    UIImage *m_image = [UIImage imageWithColor:self.slidePageView.topScrollView.backgroundColor withSize:CGSizeMake(5, 5)];
    return m_image;
}

- (UIViewController *)slideSwitchView:(YYSlideSwitchView *)view viewOfTab:(NSUInteger)number {
    NSDictionary *dic = self.viewArray[number];
    return dic[@"VC"];
}

- (void)slideSwitchView:(YYSlideSwitchView *)view didselectTab:(NSUInteger)number {
    NSDictionary *dic = self.viewArray[number];
    YYBaseSubTableVC *listVC = dic[@"VC"];
    if ([listVC respondsToSelector:@selector(becomeListed)]) {
        [listVC performSelector:@selector(becomeListed)];
    }
    
    [self.slidePageView showRedPoint:NO withIndex:number];
}

- (void)slideSwitchView:(YYSlideSwitchView *)view didunselectTab:(NSUInteger)number {
    NSDictionary *dic = self.viewArray[number];
    YYBaseSubTableVC *listVC = dic[@"VC"];
    if ([listVC respondsToSelector:@selector(becomeUnListed)]) {
        [listVC performSelector:@selector(becomeUnListed)];
    }
}

@end
