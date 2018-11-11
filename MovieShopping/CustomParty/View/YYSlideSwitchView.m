//
//  YYSlideSwitchView.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYSlideSwitchView.h"
#import "UIView+KGViewExtend.h"

#define scrollBtnBaseTag  10000
#define redPointBaseTag 1000
#define shadowWidthScale 0.8

static const CGFloat kWidthOfButtonMargin = 0.0f;
static const CGFloat kFontSizeOfTabButton = 14.0f;
static const NSUInteger kTagOfRightSideButton = 999;

@interface UIButton(ImageAndText)

- (void)verticalImageAndTitle:(CGFloat)spacing;

@end

@implementation UIButton(ImageAndText)

- (void)verticalImageAndTitle:(CGFloat)spacing{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = 0;
    
    NSStringDrawingOptions drawOptions = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attibutes = @{NSFontAttributeName:self.titleLabel.font, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGSize textSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:drawOptions attributes:attibutes context:nil].size;
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

@end


@implementation YYSlideSwitchView

#pragma mark - 初始化参数
- (void)initValues {
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = scrollBtnBaseTag + 0;
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.scrollEnabled = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        kHeightOfTopScrollView = 44.0;
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        kHeightOfTopScrollView = 44.0;
        [self initValues];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withHeightOfTop:(CGFloat)topHeight {
    self = [super initWithFrame:frame];
    if (self) {
        kHeightOfTopScrollView = topHeight;
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter
- (NSUInteger)selectedIndex {
    return _userSelectedChannelID - scrollBtnBaseTag;
}

- (void)setRigthSideButton:(UIButton *)rigthSideButton {
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
    
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews {
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width > 0) {
            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0, _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
            
            _topScrollView.frame = CGRectMake(0, 0,
                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * self.viewArray.count, 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < self.viewArray.count; i++) {
            UIViewController *listVC = self.viewArray[i];
            listVC.view.frame = CGRectMake(0 + _rootScrollView.bounds.size.width * i, 0, _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - scrollBtnBaseTag) * self.bounds.size.width, 0) animated:NO];
        
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
    }
}

/*!
 * @method 创建子视图UI
 
 */
- (void)buildUI {
    _isBuildUI = NO;
    _userSelectedChannelID = scrollBtnBaseTag;
    [self.viewArray removeAllObjects];
    for (UIView *subView in _topScrollView.subviews) {
        if (![subView isEqual:self.rigthSideButton]) {
            [subView removeFromSuperview];
        }
    }
    for (UIView *subView in _rootScrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    NSUInteger number = [self.delegate numberOfTab:self];
    for (int i = 0; i < number; i++) {
        UIViewController *vc = [self.delegate slideSwitchView:self viewOfTab:i];
        [self.viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.delegate slideSwitchView:self didselectTab:_userSelectedChannelID - scrollBtnBaseTag];
    }
    
    _isBuildUI = YES;
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

/*!
 * @method 初始化顶部tab的各个按钮
 
 */
- (void)createNameButtons{
    _shadowImageView = [[UIImageView alloc] init];
    _shadowImageView.backgroundColor = self.tabItemSelectedColor;
    [_topScrollView addSubview:_shadowImageView];
    
    //    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _topScrollView.contentSize.height - 1, _topScrollView.contentSize.width, 1)];
    //    lineView.backgroundColor = RGBA(0x66, 0x66, 0x66, 0.2);
    //    [_topScrollView addSubview:lineView];
    
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = kWidthOfButtonMargin;
    //每个tab偏移量
    CGFloat xOffset = kWidthOfButtonMargin;
    for (int i = 0; i < self.viewArray.count; i++) {
        NSString *titleString = [self.delegate titleOfTab:i];
        double tabWidth = [self.delegate widthOfTab:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //累计每个tab的长度
        topScrollViewContentWidth += tabWidth;
        //设置按钮尺寸
        [button setFrame:CGRectMake(xOffset,0, tabWidth, kHeightOfTopScrollView)];
        //计算下一个tab的x偏移量
        xOffset += tabWidth + kWidthOfButtonMargin;
        button.tag = scrollBtnBaseTag + i;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, button.height - 0.5, button.width, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:0x66 /255.0 green:0x66 /255.0 blue:0x66 /255.0 alpha:0.4];
        lineView.tag = 10;
        [button addSubview:lineView];
        if (i == 0) {
            _shadowImageView.frame = CGRectMake(kWidthOfButtonMargin + 0.5 * (1 - shadowWidthScale) * tabWidth, _topScrollView.bounds.size.height - 1, shadowWidthScale * tabWidth, 2);
            button.selected = YES;
        }
        
        //        button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:titleString forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
        
        if ([self.delegate respondsToSelector:@selector(normalImageNameOfTab:)]) {
            UIImage *normal_image = [self.delegate normalImageNameOfTab:i];
            if (normal_image) {
                [button setImage:normal_image  forState:UIControlStateNormal];
                [button verticalImageAndTitle: 8.0];
            }
        }
        if ([self.delegate respondsToSelector:@selector(selectedImageNameOfTab:)]) {
            [button setImage:[UIImage imageNamed:[self.delegate selectedImageNameOfTab:i]] forState:UIControlStateSelected];
        }
        
        NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = 0;
        
        NSStringDrawingOptions drawOptions = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attibutes = @{NSFontAttributeName:button.titleLabel.font,NSParagraphStyleAttributeName:paragraphStyle};
        
        CGSize labelSize = [button.titleLabel.text boundingRectWithSize:CGSizeMake(button.bounds.size.width, button.bounds.size.height) options:drawOptions attributes:attibutes context:nil].size;
        
        UIView *redPointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
        redPointView.backgroundColor = [UIColor redColor];
        redPointView.layer.cornerRadius = 0.5 * redPointView.bounds.size.width;
        redPointView.layer.masksToBounds = YES;
        redPointView.center = CGPointMake(0.5 * button.bounds.size.width + 0.5 * labelSize.width + 5, 0.4 * button.bounds.size.height);
        [button addSubview:redPointView];
        
        redPointView.tag = redPointBaseTag + i;
        redPointView.hidden = YES;
    }
    
    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
    //    lineView.frame = CGRectMake(0, _topScrollView.contentSize.height - 1, _topScrollView.contentSize.width, 1);
    
}

//设置小红点视图的显示
- (void)showRedPoint:(BOOL)isShow withIndex:(NSUInteger)index{
    if (index < self.viewArray.count) {
        UIView *redPointView = [self viewWithTag:redPointBaseTag + index];
        if (redPointView) {
            redPointView.hidden = !isShow;
        }
    }
}

//重载tab标题
- (void)reloadTabTitles{
    for (int i = 0; i < self.viewArray.count; i++) {
        NSString *titleString = [self.delegate titleOfTab:i];
        
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:i + scrollBtnBaseTag];
        [button setTitle:titleString forState:UIControlStateNormal];
    }
}

#pragma mark - getter
- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [NSMutableArray new];
    }
    return _viewArray;
}

#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 */
- (void)selectNameButton:(UIButton *)sender{
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        UIView *lineView = [lastButton viewWithTag:10];
        lineView.hidden = lastButton.selected;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwitchView:didunselectTab:)]) {
            [self.delegate slideSwitchView:self didunselectTab:_userSelectedChannelID - scrollBtnBaseTag];
        }
        
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        [UIView animateWithDuration:0.01 animations:^{
            //            _shadowImageView.frame = CGRectMake(sender.frame.origin.x + 0.5 * (1 - shadowWidthScale) * sender.frame.size.width, _shadowImageView.frame.origin.y, shadowWidthScale * sender.frame.size.width, _shadowImageView.frame.size.height);
            _shadowImageView.centerX = sender.centerX;
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - scrollBtnBaseTag) * self.bounds.size.width, 0) animated:NO];
                }
                _isRootScroll = NO;
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.delegate slideSwitchView:self didselectTab:_userSelectedChannelID - scrollBtnBaseTag];
                }
            }
        }];
    }
    //重复点击选中按钮
    else {
        
    }
}

/*!
 * @method 调整顶部滚动视图x位置
 
 */
- (void)adjustScrollViewContentX:(UIControl *)sender {
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - (_topScrollView.bounds.size.width- (kWidthOfButtonMargin+sender.bounds.size.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - kWidthOfButtonMargin, 0)  animated:YES];
    }
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x / self.bounds.size.width + scrollBtnBaseTag;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam {
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.delegate
            && [self.delegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.delegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
        if (self.delegate
            && [self.delegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.delegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

@end

