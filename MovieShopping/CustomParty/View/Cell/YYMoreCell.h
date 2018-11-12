//
//  YYMoreCell.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYCollectionView.h"
#import "YYCellHeaderView.h"

#define Event_MoreCellItemSelected @"MoreCellItemSelected"

@interface YYMoreCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) YYCollectionView *collectionView;
@property (nonatomic, copy) NSArray *dataList;

@end
