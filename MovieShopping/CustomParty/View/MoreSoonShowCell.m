//
//  MoreSoonShowCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "MoreSoonShowCell.h"
#import "YYCollectionCell.h"
#import "YYViewPublic.h"
#import "UIImageView+WebCache.h"
#import "UIResponder+Router.h"

static NSString *cellID = @"cell_soon_show";

@interface SoonShowCollectionCell: YYCollectionCell

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation SoonShowCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.showLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.showLabel.bottom, self.width, 14)];
        _timeLabel.textColor = YYTextColor;
        _timeLabel.font = self.showLabel.font;
        _timeLabel.textAlignment = self.showLabel.textAlignment;
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

@end

@implementation MoreSoonShowCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.headerView addSubview:NewSeparatorLine(CGRectMake(0, 0, self.headerView.width, 2.0))];
    self.headerLabel.text = @"即将上映";
    [self.collectionView registerClass:[SoonShowCollectionCell class] forCellWithReuseIdentifier:cellID];
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
    SoonShowCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataList[indexPath.row];
    [cell.showImageView sd_setImageWithURL:dic[@"BackgroundPicture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.showLabel.text = dic[@"ShowName"];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@上映", dic[@"OpenDay"]];
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
    [self routerEventWithName:Event_SoonShowSellSelected userInfo:indexPath];
}

@end
