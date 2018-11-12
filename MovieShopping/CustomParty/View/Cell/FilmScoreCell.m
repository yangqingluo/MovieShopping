//
//  FilmScoreCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "FilmScoreCell.h"

@implementation FilmScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.likeBtn.layer.cornerRadius = 5;
    self.likeBtn.layer.masksToBounds = YES;
    self.watchedBtn.layer.cornerRadius = 5;
    self.watchedBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
