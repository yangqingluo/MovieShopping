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

@interface FilmSoonSubTableVC ()

@end

@implementation FilmSoonSubTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YYLightWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSArray *m_array = [filmString mj_JSONObject][@"movieList"];
    [self.dataList addObjectsFromArray:m_array];
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
    [cell.showImageView sd_setImageWithURL:dic[@"BackgroundPicture"] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.nameLabel.text = dic[@"ShowName"];
    if (dic[@"BuyPre"]) {
        [cell.buyBtn setTitle:@"预售" forState:UIControlStateNormal];
        cell.buyBtn.backgroundColor = YYBlueColor;
    }
    else {
        [cell.buyBtn setTitle:@"购票" forState:UIControlStateNormal];
        cell.buyBtn.backgroundColor = YYRedColor;
    }
    cell.scoreLabel.text = dic[@"Remark"];
    cell.directorLabel.text = [NSString stringWithFormat:@"导演：%@", dic[@"Director"]];
    cell.leadingRoleLabel.text = [NSString stringWithFormat:@"主演：%@", dic[@"LeadingRole"]];
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
    _headerLabel.text = [NSString stringWithFormat:@"%@上映", dic[@"OpenDay"]];
    return _headerView;
}

@end
