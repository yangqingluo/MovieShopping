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
#import "FilmPerformerCell.h"
#import "FilmStillCell.h"
#import "CommentCell.h"
#import "YYCellHeaderView.h"
#import "YYCellFooterView.h"
#import "PerformerListVC.h"
#import "FilmSelectCinemaVC.h"

@interface FilmDetailVC ()<TLDisplayViewDelegate> {
    
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) FilmInfoView *infoView;
@property (nonatomic, strong) FilmScoreCell *scoreCell;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic,strong) NSDictionary *headerInfoDic;
@property (nonatomic,strong) NSArray *directorsList;//导演列表
@property (nonatomic,strong) NSArray *actorsList;//演员表
@property (nonatomic,strong) NSDictionary *mboxDic;//票房数据
@property (nonatomic,strong) NSArray *commentModelArray;//评论表
@property (nonatomic,strong) NSString *commentTotalCount; //评论总数

@end

@implementation FilmDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnAction)];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self loadData];
}

- (void)shareBtnAction {
    
}

- (void)loadData {
    [self showHudInView:self.view hint:nil];
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //3.添加请求
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [[YYNetwork getInstance] getHTTPPath:API_MOVIE_DETAIL(self.sourceData[@"Id"]) response:^(id response, NSError *error) {
            dispatch_group_leave(group);
            if (error) {
                
            }
            else {
                self.headerInfoDic = response[@"data"][@"movie"];
            }
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [[YYNetwork getInstance] getHTTPPath:API_MOVIE_PERFORMER(self.sourceData[@"Id"]) response:^(id response, NSError *error) {
            dispatch_group_leave(group);
            if (error) {
                
            }
            else {
                self.directorsList = response[@"data"][@"directors"];
                self.actorsList = response[@"data"][@"actors"];
            }
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [[YYNetwork getInstance] getHTTPPath:API_MOVIE_COMMENT_SHOT(self.sourceData[@"Id"], @"0", @"1", @"0") response:^(id response, NSError *error) {
            dispatch_group_leave(group);
            if (error) {
                
            }
            else {
                self.commentTotalCount = [response[@"total"] stringValue];
                self.commentModelArray = response[@"hcmts"];
            }
        }];
    });
    
    //4.队列组所有请求完成回调刷新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self hideHud];
        [self.tableView reloadData];
    });
}

- (void)cellFooterMoreBtnAction:(UIButton *)button {
    switch (button.tag) {
        case 0: {
            PerformerListVC *vc = [[PerformerListVC alloc] initWithStyle:UITableViewStylePlain];
            vc.sourceData = self.sourceData;
            vc.performerList = @[self.directorsList, self.actorsList];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)footerBuyBtnAction {
    FilmSelectCinemaVC *vc = [FilmSelectCinemaVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
        
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
        
        UIView *m_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _infoView.width, _infoView.bottom)];
        m_view.backgroundColor = YYLightRedColor;
        [_headerView addSubview:m_view];
        [_headerView addSubview:_infoView];
        
        NSString *nibName = NSStringFromClass([FilmScoreCell class]);
        FilmScoreCell *cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
        
        cell.scoreLabel.text = dic[@"Remark"];
        cell.scoreView.value = [dic[@"Remark"] doubleValue] / 2.0;
        cell.wishLabel = dic[@"Wish"];
        TLDisplayView *_displayView = [[TLDisplayView alloc] init];
        _displayView.delegate = self;
        _displayView.font = [UIFont systemFontOfSize: 14.0];
        _displayView.backgroundColor = [UIColor clearColor];
        _displayView.numberOfLines = 3;
        [_displayView setText:dic[@"Description"]];
        [_displayView setOpenString:@"展开" closeString:@"收起" font: _displayView.font textColor:YYBlueColor];
        CGSize size = [_displayView sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * YYEdgeBig, MAXFLOAT)];
        _displayView.frame = CGRectMake(YYEdgeBig, 140, size.width, size.height);
        [cell.contentView addSubview:_displayView];
        cell.top = _infoView.bottom;
        [_headerView addSubview:cell];
        _headerView.height = cell.bottom + YYEdge;
        self.scoreCell = cell;
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        UIButton *buyBtn = [[UIButton alloc] initWithFrame:_footerView.bounds];
        buyBtn.backgroundColor = YYRedColor;
        [buyBtn setTitle:@"特惠购票" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_footerView addSubview:buyBtn];
        [buyBtn addTarget:self action:@selector(footerBuyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return MIN(3, self.commentModelArray.count);
    }
    return 1;
}

// 预测cell的高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 200.0;
        case 1:
            return 120.0;
        default:
            return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [YYCellHeaderView height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [YYCellFooterView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YYCellHeaderView *view = [YYCellHeaderView new];
    view.topLine.hidden = NO;
    view.moreBtn.hidden = YES;
    switch (section) {
        case 0:
            view.headerLabel.text = @"演职人员";
            return view;
        case 1:
            view.headerLabel.text = @"剧照";
            return view;
        case 2:
            view.headerLabel.text = @"评论";
            return view;
        default:
            return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YYCellFooterView *view = [YYCellFooterView new];
    view.moreBtn.tag = section;
    [view.moreBtn addTarget:self action:@selector(cellFooterMoreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    switch (section) {
        case 0:
            [view.moreBtn setTitle:[NSString stringWithFormat:@"全部%lu位演职人员", (unsigned long)self.actorsList.count] forState:UIControlStateNormal];
            return view;
        case 1:
            [view.moreBtn setTitle:[NSString stringWithFormat:@"全部%lu张剧照", (unsigned long)[(NSArray *)self.headerInfoDic[@"photos"] count]] forState:UIControlStateNormal];
            return view;
        case 2:
            [view.moreBtn setTitle:[NSString stringWithFormat:@"全部%@条评论", self.commentTotalCount] forState:UIControlStateNormal];
            return view;
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellID = @"cell_Perfomer";
        FilmPerformerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[FilmPerformerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        NSMutableArray *m_array = [NSMutableArray new];
        [m_array addObjectsFromArray:self.directorsList];
        [m_array addObjectsFromArray:self.actorsList];
        cell.dataList = m_array;
        [cell.collectionView reloadData];
        return cell;
    }
    else if (indexPath.section == 1) {
        static NSString *cellID = @"cell_FilmStill";
        FilmStillCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[FilmStillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.dataList = self.headerInfoDic[@"photos"];
        [cell.collectionView reloadData];
        return cell;
    }
    else if (indexPath.section == 2) {
        static NSString *cellID = @"cell_Comment";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            NSString *nibName = NSStringFromClass([CommentCell class]);
            [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellID];
            cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
        }
        cell.separatorLineColor = [UIColor clearColor];
        NSDictionary *model = self.commentModelArray[indexPath.row];
        cell.commentModel = model;
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark -
#pragma mark TLDisplayViewDelegate
- (void)displayView:(TLDisplayView *)displayView textHeight:(CGFloat)height {
    self.scoreCell.height = displayView.bottom;
    self.headerView.height = self.scoreCell.bottom + YYEdge;
    self.tableView.tableHeaderView = nil;
    self.tableView.tableHeaderView = self.headerView;
}

//#pragma mark - UIResponder+Router
//- (void)routerEventWithName:(NSString *)eventName from:(id)fromObject userInfo:(NSObject *)userInfo {
//    if ([eventName isEqualToString:Event_MoreCellItemSelected]) {
//        NSIndexPath *indexPath = (NSIndexPath *)userInfo;
//        
//    }
//}

@end
