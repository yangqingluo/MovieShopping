//
//  YYSlideSwitchView.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYSlideSwitchViewDelegate;

@interface YYSlideSwitchView : UIView<UIScrollViewDelegate> {
    CGFloat kHeightOfTopScrollView;
}

@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, strong) UIScrollView *rootScrollView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, assign) CGFloat userContentOffsetX;
@property (nonatomic, assign) NSInteger userSelectedChannelID;
@property (nonatomic, weak)  id<YYSlideSwitchViewDelegate> delegate;
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) UIButton *rigthSideButton;
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;

@property (nonatomic, assign) BOOL isLeftScroll;//是否左滑动
@property (nonatomic, assign) BOOL isRootScroll;//是否主视图滑动
@property (nonatomic, assign) BOOL isBuildUI;//是否建立了ui

- (instancetype)initWithFrame:(CGRect)frame withHeightOfTop:(CGFloat)topHeight;

/*!
 * @method 创建子视图UI
 */
- (void)buildUI;

//设置小红点视图的显示
- (void)showRedPoint:(BOOL)isShow withIndex:(NSUInteger)index;

//重载tab标题
- (void)reloadTabTitles;

@end

@protocol YYSlideSwitchViewDelegate <NSObject>

@required

- (CGFloat)widthOfTab:(NSUInteger)index;
- (NSString *)titleOfTab:(NSUInteger)index;

/*!
 * @method 顶部tab个数
 */
- (NSUInteger)numberOfTab:(YYSlideSwitchView *)view;

/*!
 * @method 每个tab所属的viewController
 */
- (UIViewController *)slideSwitchView:(YYSlideSwitchView *)view viewOfTab:(NSUInteger)number;

@optional

- (UIImage *)normalImageNameOfTab:(NSUInteger)index;
- (NSString *)selectedImageNameOfTab:(NSUInteger)index;

/*!
 * @method 滑动左边界时传递手势
 */
- (void)slideSwitchView:(YYSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 滑动右边界时传递手势
 */
- (void)slideSwitchView:(YYSlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 点击tab
 */
- (void)slideSwitchView:(YYSlideSwitchView *)view didselectTab:(NSUInteger)number;

/*!
 * @method 取消选中点击tab
 */
- (void)slideSwitchView:(YYSlideSwitchView *)view didunselectTab:(NSUInteger)number;

@end
