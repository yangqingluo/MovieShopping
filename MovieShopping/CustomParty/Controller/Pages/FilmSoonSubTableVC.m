//
//  FileSoonSubTableVC.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "FilmSoonSubTableVC.h"
#import "FilmCell.h"
#import "UIImageView+WebCache.h"
#import "FilmDetailVC.h"
#import "YYPublic.h"

@interface FilmSoonSubTableVC ()

@end

@implementation FilmSoonSubTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YYLightWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self updateTableViewHeader];
}

#pragma mark - Networking
- (void)pullBaseListData:(BOOL)isReset {
    [self showHudInView:self.view hint:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue, ^{
        [[YYNetwork getInstance] POST:@17 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
            if (error) {
                
            }
            else {
                YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
                if (result.code == HTTP_SUCCESS) {
                    if (isReset) {
                        [weakSelf.dataList removeAllObjects];
                    }
                    [weakSelf.dataList addObjectsFromArray:result.data.items];
                    if (result.data.total > self.dataList.count) {
                        [self updateTableViewFooter];
                    }
                    else {
                        self.tableView.mj_footer = nil;
                    }
                }
                [weakSelf endRefreshing];
                [weakSelf updateSubviews];
            }
        }];
    });
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_film";
    FilmCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSString *nibName = NSStringFromClass([FilmCell class]);
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:ID];
        cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
    }
    NSDictionary *dic = self.dataList[indexPath.section];
    [cell.showImageView sd_setImageWithURL:dic[@"background_picture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.nameLabel.text = dic[@"show_name"];
    if ([dic[@"market"] isEqualToString:@"2"]) {
        [cell.buyBtn setTitle:@"预售" forState:UIControlStateNormal];
        cell.buyBtn.backgroundColor = YYBlueColor;
    }
    else {
        [cell.buyBtn setTitle:@"购票" forState:UIControlStateNormal];
        cell.buyBtn.backgroundColor = YYRedColor;
    }
    cell.scoreLabel.text = dic[@"remark"];
    cell.directorLabel.text = [NSString stringWithFormat:@"导演：%@", dic[@"director"]];
    cell.leadingRoleLabel.text = [NSString stringWithFormat:@"主演：%@", dic[@"leading_role"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YYScreenWidth, 40)];
    _headerView.backgroundColor = [UIColor whiteColor];
    UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(YYEdgeMiddle, 0, 4, 20)];
    redLine.backgroundColor = [UIColor redColor];
    redLine.centerY = 0.5 * _headerView.height;
    [_headerView addSubview:redLine];
    
    UILabel *_headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(redLine.right + YYEdgeMiddle, 0, 200, _headerView.height)];
    _headerLabel.font = [UIFont systemFontOfSize:YYLabelFontSize];
    _headerLabel.textColor = YYTextColor;
    [_headerView addSubview:_headerLabel];
    
    NSDictionary *dic = self.dataList[section];
    _headerLabel.text = [NSString stringWithFormat:@"%@上映", dic[@"open_time"]];
    return _headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FilmDetailVC *vc = [FilmDetailVC new];
    vc.sourceData = self.dataList[indexPath.section];
    [[YYPublic getInstance].mainNav pushViewController:vc animated:YES];
}

@end
