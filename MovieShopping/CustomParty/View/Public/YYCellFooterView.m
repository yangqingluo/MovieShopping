//
//  YYCellFooterView.m
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import "YYCellFooterView.h"
#import "YYViewPublic.h"

#define Height_YYCellFooterView 50.0

@implementation YYCellFooterView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, YYScreenWidth, Height_YYCellFooterView)];
    if (self) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:YYButtonTitleFontSize];
        [_moreBtn setTitleColor:YYBlueColor forState:UIControlStateNormal];
        _moreBtn.frame = self.bounds;
        [self addSubview:_moreBtn];
    }
    return self;
}

+ (CGFloat)height {
    return Height_YYCellFooterView;
}

@end
