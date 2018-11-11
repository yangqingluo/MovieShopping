//
//  FilmInfoView.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "FilmInfoView.h"
#import "YYViewPublic.h"

@implementation FilmInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (self.height < 180) {
            self.height = 180;
        }
        CGFloat i_radius = 120.0;
        _showImageView = [[YYImageView alloc] initWithFrame:CGRectMake(self.width - i_radius - YYEdgeMiddle, YYEdge, i_radius, i_radius / 0.75)];
        _showImageView.layer.cornerRadius = 5;
        _showImageView.layer.masksToBounds = YES;
        _showImageView.titleLabel.backgroundColor = [UIColor whiteColor];
        _showImageView.titleLabel.textColor = YYTextColor;
        _showImageView.titleLabel.font = [UIFont systemFontOfSize: 10.0];
        _showImageView.titleLabel.textAlignment = NSTextAlignmentCenter;
        _showImageView.titleLabel.layer.cornerRadius = 2.0;
        _showImageView.titleLabel.layer.masksToBounds = YES;
        [self addSubview:_showImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(YYEdgeMiddle, self.showImageView.top, self.showImageView.left - YYEdge, 40)];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:YYLabelFontSizeMiddle];
        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, self.nameLabel.width, 30)];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.font = [UIFont systemFontOfSize:YYLabelFontSizeSmall];
        [self addSubview:_typeLabel];
        
        _durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.typeLabel.bottom, self.nameLabel.width, 30)];
        _durationLabel.textColor = self.typeLabel.textColor;
        _durationLabel.font = self.typeLabel.font;
        [self addSubview:_durationLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.durationLabel.bottom, self.nameLabel.width, 30)];
        _dateLabel.textColor = self.typeLabel.textColor;
        _dateLabel.font = self.typeLabel.font;
        [self addSubview:_dateLabel];
    }
    return self;
}

@end
