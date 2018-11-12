//
//  YYCellHeaderView.m
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import "YYCellHeaderView.h"
#import "YYViewPublic.h"
#import "Swift.h"

#define Height_YYCellHeaderView 50.0

@implementation YYCellHeaderView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, YYScreenWidth, Height_YYCellHeaderView)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _topLine = NewSeparatorLine(CGRectMake(0, 0, self.width, 0.5));
        _topLine.hidden = YES;
        [self addSubview:_topLine];
        
        UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(YYEdgeMiddle, 0, 4, 20)];
        redLine.backgroundColor = [UIColor redColor];
        redLine.centerY = 0.5 * self.height;
        [self addSubview:redLine];
        
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(redLine.right + YYEdgeMiddle, 0, 200, self.height)];
        _headerLabel.font = [UIFont systemFontOfSize:YYLabelFontSize];
        _headerLabel.textColor = YYTextColor;
        [self addSubview:_headerLabel];
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitleColor:YYTextColor forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:YYButtonTitleFontSize];
        _moreBtn.frame = CGRectMake(0, 0, 80, 40);
        _moreBtn.right = self.width;
        _moreBtn.centerY = redLine.centerY;
        [_moreBtn setWithImage:[UIImage imageNamed:@"arrow_more"] title:@"全部" titlePosition:UIViewContentModeLeft additionalSpacing:YYEdgeMiddle state:UIControlStateNormal];
        [self addSubview:_moreBtn];
    }
    return self;
}

+ (CGFloat)height {
    return Height_YYCellHeaderView;
}

@end
