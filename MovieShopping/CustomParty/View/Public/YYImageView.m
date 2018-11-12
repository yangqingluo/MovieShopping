//
//  YYImageView.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYImageView.h"

@implementation YYImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(frame) - 2 * 5, 14)];
        _titleLabel.hidden = YES;
        [self addSubview:_titleLabel];
    }
    return self;
}

@end
