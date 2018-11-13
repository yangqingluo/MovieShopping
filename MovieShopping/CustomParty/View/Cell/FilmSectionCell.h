//
//  FilmSectionCell.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/14.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmSectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *hallLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end
