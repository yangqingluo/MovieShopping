//
//  YYMoreCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYMoreCell.h"
#import "YYViewPublic.h"
#import "Swift.h"

@implementation YYMoreCell

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, YYScreenWidth, 240)];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headerView];
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 60)];
        UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(YYEdgeMiddle, 0, 4, 30)];
        redLine.backgroundColor = [UIColor redColor];
        redLine.centerY = 0.5 * _headerView.height;
        [_headerView addSubview:redLine];
        
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(redLine.right + YYEdgeMiddle, 0, 200, _headerView.height)];
        _headerLabel.font = [UIFont systemFontOfSize:YYLabelFontSize];
        _headerLabel.textColor = YYTextColor;
        [_headerView addSubview:_headerLabel];
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitleColor:YYTextColor forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:YYButtonTitleFontSize];
        _moreBtn.frame = CGRectMake(0, 0, 80, 40);
        _moreBtn.right = _headerView.width;
        _moreBtn.centerY = redLine.centerY;
        [_moreBtn setWithImage:[UIImage imageNamed:@"arrow_more"] title:@"全部" titlePosition:UIViewContentModeLeft additionalSpacing:YYEdgeMiddle state:UIControlStateNormal];
        [_headerView addSubview:_moreBtn];
    }
    return _headerView;
}

@end
