//
//  FilmHotSubTableVC.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "FilmHotSubTableVC.h"
#import "FilmCell.h"
#import "UIImageView+WebCache.h"
#import "FilmDetailVC.h"
#import "YYPublic.h"

@implementation FilmHotSubTableVC

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
        [[YYNetwork getInstance] POST:@16 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
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
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = self.dataList[indexPath.row];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FilmDetailVC *vc = [FilmDetailVC new];
    vc.sourceData = self.dataList[indexPath.row];
    [[YYPublic getInstance].mainNav pushViewController:vc animated:YES];
}

@end
