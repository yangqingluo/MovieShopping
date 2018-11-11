//
//  FilmDetailVC.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "FilmDetailVC.h"
#import "FilmInfoView.h"
#import "UIImageView+WebCache.h"

@interface FilmDetailVC ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) FilmInfoView *infoView;

@end

@implementation FilmDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnAction)];
    
    self.tableView.tableHeaderView = self.headerView;
}

- (void)shareBtnAction {
    
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT + 180)];
        _headerView.backgroundColor = YYLightRedColor;
        
        _infoView = [[FilmInfoView alloc] initWithFrame:CGRectMake(0, YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT, _headerView.width, 180.0)];
        [_infoView.showImageView sd_setImageWithURL:self.sourceData[@"BackgroundPicture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
        _infoView.nameLabel.text = self.sourceData[@"ShowName"];
        _infoView.typeLabel.text = self.sourceData[@"Type"];
        _infoView.durationLabel.text = [NSString stringWithFormat:@"%@/%@分钟", self.sourceData[@"Country"], self.sourceData[@"Duration"]];
        _infoView.dateLabel.text = [NSString stringWithFormat:@"%@ 在 %@上映", self.sourceData[@"OpenDay"], self.sourceData[@"Country"]];
        [_headerView addSubview:_infoView];
    }
    return _headerView;
}

@end
