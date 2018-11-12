//
//  FilmPerformerCell.m
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import "FilmPerformerCell.h"
#import "YYCollectionCell.h"
#import "YYViewPublic.h"
#import "UIImageView+WebCache.h"

static NSString *cellID = @"cell_performer";

@implementation FilmPerformerCell

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
    
    NSString *imgURLString = [dic[@"avatar"] stringByReplacingOccurrencesOfString:@"w.h" withString:@"156.220"];
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.showLabel.text = dic[@"cnm"];
    cell.subLabel.textColor = [UIColor lightGrayColor];
    cell.subLabel.height = 30;
    cell.subLabel.numberOfLines = 2;
    cell.subLabel.text = dic[@"roles"];
    return cell;
}

@end
