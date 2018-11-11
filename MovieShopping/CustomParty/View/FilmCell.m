//
//  FilmCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "FilmCell.h"


@implementation FilmCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.baseView.layer.cornerRadius = 5;
    self.baseView.layer.masksToBounds = YES;
    
    self.showImageView.layer.cornerRadius = 5;
    self.showImageView.layer.masksToBounds = YES;
    
    self.buyBtn.layer.cornerRadius = 0.5 * self.buyBtn.frame.size.height;
    self.buyBtn.layer.masksToBounds = YES;
    
    self.leadingRoleLabel.verticalAlignment = VerticalAlignmentTop;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
