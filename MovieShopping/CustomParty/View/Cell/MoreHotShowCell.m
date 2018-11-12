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

@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation HotShowCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat m_height = 30;
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.frame = CGRectMake(0, self.showLabel.bottom + YYEdgeSmall, 50, m_height);
        _buyBtn.centerX = 0.5 * self.contentView.width;
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:YYButtonTitleFontSize];
        _buyBtn.layer.cornerRadius = 0.5 * _buyBtn.height;
        _buyBtn.layer.masksToBounds = YES;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_buyBtn];
        [_buyBtn addTarget:self action:@selector(sellBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)sellBtnAction:(UIButton *)button {
    [self routerEventWithName:Event_HotShowCellButtonClicked userInfo:@(button.tag)];
}

@end

@implementation MoreHotShowCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView registerClass:[HotShowCollectionCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark <UICollectionViewDataSource>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, collectionView.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotShowCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataList[indexPath.row];
    [cell.showImageView sd_setImageWithURL:dic[@"BackgroundPicture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.showLabel.text = dic[@"ShowName"];
    cell.buyBtn.tag = indexPath.row;
    if (dic[@"BuyPre"]) {
        [cell.buyBtn setTitle:@"预售" forState:UIControlStateNormal];
        cell.buyBtn.backgroundColor = YYBlueColor;
    }
    else {
        [cell.buyBtn setTitle:@"购票" forState:UIControlStateNormal];
        cell.buyBtn.backgroundColor = YYRedColor;
    }
    if (dic[@"ShowMark"] && [(NSString *)dic[@"ShowMark"] length]) {
        cell.showImageView.titleLabel.text = dic[@"ShowMark"];
        cell.showImageView.titleLabel.hidden = NO;
        adjustLabelWidthWithEdge(cell.showImageView.titleLabel, 1.0);
    }
    else {
        cell.showImageView.titleLabel.text = @"";
        cell.showImageView.titleLabel.hidden = YES;
    }
    return cell;
}

@end
