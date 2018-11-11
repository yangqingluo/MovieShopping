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
#import "FilmScoreCell.h"

@interface FilmDetailVC ()<TLDisplayViewDelegate> {
    CGFloat _textHeight;
    TLDisplayView *_displayView;//电影简介
}

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
        
        NSDictionary *dic = self.sourceData;
        _infoView = [[FilmInfoView alloc] initWithFrame:CGRectMake(0, YY_STATUS_BAR_HEIGHT + YY_NAVIGATION_BAR_HEIGHT, _headerView.width, 180.0)];
        [_infoView.showImageView sd_setImageWithURL:dic[@"BackgroundPicture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
        _infoView.nameLabel.text = dic[@"ShowName"];
        _infoView.typeLabel.text = dic[@"Type"];
        _infoView.durationLabel.text = [NSString stringWithFormat:@"%@/%@分钟", dic[@"Country"], dic[@"Duration"]];
        _infoView.dateLabel.text = [NSString stringWithFormat:@"%@ 在 %@上映", dic[@"OpenDay"], dic[@"Country"]];
        if (dic[@"ShowMark"] && [(NSString *)dic[@"ShowMark"] length]) {
            _infoView.showImageView.titleLabel.text = dic[@"ShowMark"];
            _infoView.showImageView.titleLabel.hidden = NO;
            adjustLabelWidthWithEdge(_infoView.showImageView.titleLabel, 1.0);
        }
        else {
            _infoView.showImageView.titleLabel.text = @"";
            _infoView.showImageView.titleLabel.hidden = YES;
        }
        [_headerView addSubview:_infoView];
    }
    return _headerView;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210 + MAX(_textHeight, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.sourceData;
    static NSString *scoreID = @"cell_Score";
    FilmScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:scoreID];
    if (!cell) {
        NSString *nibName = NSStringFromClass([FilmScoreCell class]);
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:scoreID];
        cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
    }
    
    cell.scoreLabel.text = dic[@"Remark"];
    cell.scoreView.value = [dic[@"Remark"] doubleValue] / 2.0;
    cell.wishLabel = dic[@"Wish"];
    if (!_displayView) {
        _displayView = [[TLDisplayView alloc] init];
        _displayView.delegate = self;
        _displayView.font = [UIFont systemFontOfSize: 14.0];
        _displayView.backgroundColor = [UIColor clearColor];
        _displayView.numberOfLines = 3;
        [_displayView setText:dic[@"Description"]];
        [_displayView setOpenString:@"展开" closeString:@"收起" font: _displayView.font textColor:[UIColor blueColor]];
        
        CGSize size = [_displayView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YYEdgeBig, MAXFLOAT)];
        _displayView.frame = CGRectMake(YYEdgeBig, 140, size.width, size.height);
    }
    [cell.contentView addSubview:_displayView];
    cell.displayView = _displayView;
    
    return cell;
}

#pragma mark -
#pragma mark TLDisplayViewDelegate
- (void)displayView:(TLDisplayView *)label closeHeight:(CGFloat)height {
    _displayView.height = height;
    _textHeight = height - 60;
    [self.tableView reloadData];
}

- (void)displayView:(TLDisplayView *)label openHeight:(CGFloat)height {
    _displayView.height = height;
    _textHeight = height - 60;
    [self.tableView reloadData];
}

@end
