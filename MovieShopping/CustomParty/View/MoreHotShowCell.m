//
//  MoreHotShowCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "MoreHotShowCell.h"
#import "YYCollectionCell.h"
#import "YYViewPublic.h"
#import "UIImageView+WebCache.h"
#import "UIResponder+Router.h"

static NSString *cellID = @"cell_hot_show";

@interface HotShowCollectionCell: YYCollectionCell

@property (nonatomic, strong) UIButton *sellBtn;

@end

@implementation HotShowCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat m_height = 30;
        _sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sellBtn.frame = CGRectMake(0, self.showLabel.bottom + YYEdgeSmall, 60, m_height);
        _sellBtn.centerX = 0.5 * self.contentView.width;
        _sellBtn.titleLabel.font = [UIFont systemFontOfSize:YYButtonTitleFontSize];
        _sellBtn.layer.cornerRadius = 0.5 * _sellBtn.height;
        _sellBtn.layer.masksToBounds = YES;
        [_sellBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_sellBtn];
        [_sellBtn addTarget:self action:@selector(sellBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)sellBtnAction:(UIButton *)button {
    [self routerEventWithName:Event_HotShowSellButtonClicked userInfo:@(button.tag)];
}

@end

@implementation MoreHotShowCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.headerLabel.text = @"正在热映";
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    [self.collectionView registerClass:[HotShowCollectionCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, collectionView.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotShowCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataList[indexPath.row];
    [cell.showImageView sd_setImageWithURL:dic[@"BackgroundPicture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.showLabel.text = dic[@"ShowName"];
    cell.sellBtn.tag = indexPath.row;
    if (dic[@"BuyPre"]) {
        [cell.sellBtn setTitle:@"预售" forState:UIControlStateNormal];
        cell.sellBtn.backgroundColor = YYBlueColor;
    }
    else {
        [cell.sellBtn setTitle:@"购票" forState:UIControlStateNormal];
        cell.sellBtn.backgroundColor = YYRedColor;
    }
    if (dic[@"ShowMark"] && [(NSString *)dic[@"ShowMark"] length]) {
        cell.showImageView.titleLabel.text = dic[@"ShowMark"];
        cell.showImageView.titleLabel.hidden = NO;
        adjustLabelWidthWithEdge(cell.showImageView.titleLabel, 1.0);
    }
    else {
        cell.showImageView.titleLabel.text = @"";
        cell.showImageView.titleLabel.hidden = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self routerEventWithName:Event_HotShowSellSelected userInfo:indexPath];
}

@end
