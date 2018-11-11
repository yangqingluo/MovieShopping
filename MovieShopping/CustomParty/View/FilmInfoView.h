//
//  FilmInfoView.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYImageView.h"

@interface FilmInfoView : UIView

@property (nonatomic, strong) YYImageView *showImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end
