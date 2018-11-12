//
//  YYCellHeaderView.h
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCellHeaderView : UIView

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIButton *moreBtn;

+ (CGFloat)height;

@end

