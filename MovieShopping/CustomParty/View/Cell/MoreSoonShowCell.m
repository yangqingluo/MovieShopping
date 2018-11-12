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

@implementation MoreSoonShowCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView registerClass:[YYCollectionCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark <UICollectionViewDataSource>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, collectionView.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   YYCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dic = self.dataList[indexPath.row];
    [cell.showImageView sd_setImageWithURL:dic[@"BackgroundPicture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.showLabel.text = dic[@"ShowName"];
    cell.subLabel.text = [NSString stringWithFormat:@"%@上映", dic[@"OpenDay"]];
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
