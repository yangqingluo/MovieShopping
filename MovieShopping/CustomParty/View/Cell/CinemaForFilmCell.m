//
//  CinemaForFilmCell.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/13.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "CinemaForFilmCell.h"

@implementation CinemaForFilmCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - YYMovieBrowserDelegate
- (void)movieBrowser:(YYMovieBrowser *)browser didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)movieBrowser:(YYMovieBrowser *)browser didChangeItemAtIndex:(NSInteger)index {
    NSDictionary *dic = browser.movies[index];
    self.filmNameLabel.text = dic[@"show_name"];
    self.filmInfoLabel.text = [NSString stringWithFormat:@"%@分钟|%@|%@", dic[@"duration"], @"剧情", dic[@"leading_role"]];
}

static NSInteger _lastIndex = -1;
- (void)movieBrowser:(YYMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index {
    if (_lastIndex != index) {
        
    }
    _lastIndex = index;
}
@end
