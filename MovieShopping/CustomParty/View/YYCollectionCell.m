//
//  YYCollectionCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYCollectionCell.h"
#import "YYViewPublic.h"

@implementation YYCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        CGFloat i_radius = self.contentView.frame.size.width;
        _showImageView = [[YYImageView alloc] initWithFrame:CGRectMake(0, 0, i_radius, i_radius / 0.75)];
        _showImageView.layer.cornerRadius = 5;
        _showImageView.layer.masksToBounds = YES;
        _showImageView.titleLabel.backgroundColor = [UIColor whiteColor];
        _showImageView.titleLabel.textColor = YYTextColor;
        _showImageView.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        _showImageView.titleLabel.textAlignment = NSTextAlignmentCenter;
        _showImageView.titleLabel.layer.cornerRadius = 2.0;
        _showImageView.titleLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_showImageView];
        
        _showLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0, self.showImageView.bottom + YYEdge, self.contentView.width, self.contentView.height - self.showImageView.bottom - YYEdge)];
        _showLabel.textColor = YYTextColor;
        _showLabel.font = [UIFont systemFontOfSize:YYLabelFontSizeSmall];
        _showLabel.textAlignment = NSTextAlignmentCenter;
        _showLabel.numberOfLines = 2;
        _showLabel.verticalAlignment = VerticalAlignmentTop;
        [self.contentView addSubview:_showLabel];
    }
    return self;
}

@end
