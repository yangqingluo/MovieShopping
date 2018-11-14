//
//  YYMoreCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYMoreCell.h"
#import "YYViewPublic.h"
#import "Swift.h"
#import "UIResponder+Router.h"

@implementation YYMoreCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.collectionView];
}

#pragma mark - setter
- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    [self.collectionView reloadData];
}

#pragma mark - getter
- (YYCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        _flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        _flowLayout.minimumInteritemSpacing = 10.0;
        _flowLayout.minimumLineSpacing = 10.0;
        
        _collectionView = [[YYCollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
//        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

//定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, YYEdgeMiddle, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self routerEventWithName:Event_MoreCellItemSelected from:self userInfo:indexPath];
}

@end
