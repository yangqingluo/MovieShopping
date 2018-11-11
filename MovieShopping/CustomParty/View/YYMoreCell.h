//
//  YYMoreCell.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYCollectionView.h"

@interface YYMoreCell : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) YYCollectionView *collectionView;
@property (nonatomic, copy) NSArray *dataList;

@end
