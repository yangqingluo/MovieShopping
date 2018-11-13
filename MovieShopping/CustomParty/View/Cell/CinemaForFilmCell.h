//
//  CinemaForFilmCell.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/13.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYMovieBrowser.h"

@interface CinemaForFilmCell : UITableViewCell<YYMovieBrowserDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel *filmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmInfoLabel;
@property (strong, nonatomic) YYMovieBrowser *browser;

@end
