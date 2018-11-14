//
//  CinemaSectionCell.m
//  MovieShopping
//
//  Created by naver on 2018/11/14.
//  Copyright © 2018 yang. All rights reserved.
//

#import "CinemaSectionCell.h"
#import "YYLabel.h"
#import "YYPublic.h"

static NSString *cellID = @"cell_section";

@interface SectionCell: UICollectionViewCell

@property (nonatomic, strong) YYLabel *timeLabel;
@property (nonatomic, strong) YYLabel *versionLabel;
@property (nonatomic, strong) YYLabel *priceLabel;

@end

@implementation SectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = YYLightWhiteColor;
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        _timeLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0,  YYEdgeSmall, self.contentView.width, 20)];
        _timeLabel.textColor = YYTextColor;
        _timeLabel.font = [UIFont systemFontOfSize:YYLabelFontSize];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
        
        _versionLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0, self.timeLabel.bottom, self.width, 14)];
        _versionLabel.textColor = [UIColor lightGrayColor];
        _versionLabel.font = [UIFont systemFontOfSize:YYLabelFontSizeSmall];;
        _versionLabel.textAlignment = self.timeLabel.textAlignment;
        [self.contentView addSubview:_versionLabel];
        
        _priceLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0, self.versionLabel.bottom, self.width, 20)];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:YYLabelFontSize];
        _priceLabel.textAlignment = self.timeLabel.textAlignment;
        [self.contentView addSubview:_priceLabel];
    }
    return self;
}

@end

@implementation CinemaSectionCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView registerClass:[SectionCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark <UICollectionViewDataSource>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.height, collectionView.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataList[indexPath.row];
    cell.timeLabel.text = dic[@"show_time"];
    cell.versionLabel.text = dic[@"show_version"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元", dic[@"price"]];
    return cell;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(YYEdgeSmall, YYEdgeMiddle, YYEdgeSmall, 0);
//}

@end
