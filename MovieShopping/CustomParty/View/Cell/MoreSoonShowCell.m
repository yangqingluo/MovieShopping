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
    [cell.showImageView sd_setImageWithURL:dic[@"background_picture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.showLabel.text = dic[@"show_name"];
    cell.subLabel.text = [NSString stringWithFormat:@"%@上映", dic[@"open_time"]];
    if (dic[@"show_version_list"] && [(NSString *)dic[@"show_version_list"] length]) {
        cell.showImageView.titleLabel.text = dic[@"show_version_list"];
        cell.showImageView.titleLabel.hidden = NO;
        [cell.showImageView adjustTitleLabelSize];
    }
    else {
        cell.showImageView.titleLabel.text = @"";
        cell.showImageView.titleLabel.hidden = YES;
    }
    return cell;
}

@end
