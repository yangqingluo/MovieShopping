//
//  YYCollectionCell.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "YYImageView.h"

@interface YYCollectionCell : UICollectionViewCell

@property (nonatomic, strong) YYImageView *showImageView;
@property (nonatomic, strong) YYLabel *showLabel;
@property (nonatomic, strong) YYLabel *subLabel;

@end
