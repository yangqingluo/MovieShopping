//
//  YYLabel.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VerticalAlignmentMiddle = 0, // default
    VerticalAlignmentTop,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface YYLabel : UILabel

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end

@interface YYSubTitleView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end
