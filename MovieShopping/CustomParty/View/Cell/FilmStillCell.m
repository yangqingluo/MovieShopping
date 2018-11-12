//
//  FilmStillCell.m
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import "FilmStillCell.h"
#import "YYCollectionCell.h"
#import "YYViewPublic.h"
#import "UIImageView+WebCache.h"

static NSString *cellID = @"cell_still";

@implementation FilmStillCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView registerClass:[YYCollectionCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark <UICollectionViewDataSource>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.height / 0.75, collectionView.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSString *urlStr = [self.dataList[indexPath.row] stringByReplacingOccurrencesOfString:@"w.h" withString:@"156.220"];
    NSString *imgURLString = [[urlStr componentsSeparatedByString:@"@"]firstObject];
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.showImageView.frame = cell.contentView.bounds;
    return cell;
}

@end
