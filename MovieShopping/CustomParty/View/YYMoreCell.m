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

@implementation YYMoreCell

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, YYScreenWidth, 260)];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headerView];
    [self addSubview:self.collectionView];
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 50)];
        UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(YYEdgeMiddle, 0, 4, 20)];
        redLine.backgroundColor = [UIColor redColor];
        redLine.centerY = 0.5 * _headerView.height;
        [_headerView addSubview:redLine];
        
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(redLine.right + YYEdgeMiddle, 0, 200, _headerView.height)];
        _headerLabel.font = [UIFont systemFontOfSize:YYLabelFontSize];
        _headerLabel.textColor = YYTextColor;
        [_headerView addSubview:_headerLabel];
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitleColor:YYTextColor forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:YYButtonTitleFontSize];
        _moreBtn.frame = CGRectMake(0, 0, 80, 40);
        _moreBtn.right = _headerView.width;
        _moreBtn.centerY = redLine.centerY;
        [_moreBtn setWithImage:[UIImage imageNamed:@"arrow_more"] title:@"全部" titlePosition:UIViewContentModeLeft additionalSpacing:YYEdgeMiddle state:UIControlStateNormal];
        [_headerView addSubview:_moreBtn];
    }
    return _headerView;
}

- (YYCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *_flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        _flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        _flowLayout.minimumInteritemSpacing = 10.0;
        _flowLayout.minimumLineSpacing = 10.0;
        
        _collectionView = [[YYCollectionView alloc]initWithFrame:CGRectMake(YYEdgeMiddle, self.headerView.bottom, self.width - YYEdgeMiddle, self.height - self.headerView.bottom) collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

@end
