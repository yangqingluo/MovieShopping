//
//  PerformerListVC.m
//  MovieShopping
//
//  Created by naver on 2018/11/12.
//  Copyright © 2018 yang. All rights reserved.
//

#import "PerformerListVC.h"
#import "YYCellHeaderView.h"
#import "UIImageView+WebCache.h"

@interface PerformerListVC ()

@end

@implementation PerformerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@演职人员", self.sourceData[@"ShowName"]];
    [self bringTableViewUnderNavigation:YES];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.performerList[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [YYCellHeaderView height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YYCellHeaderView *view = [YYCellHeaderView new];
    view.topLine.hidden = NO;
    view.moreBtn.hidden = YES;
    switch (section) {
        case 0:
            view.headerLabel.text = @"导演";
            return view;
        case 1:
            view.headerLabel.text = @"演员";
            return view;
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell_Perfomer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    NSDictionary *dic = self.performerList[indexPath.section][indexPath.row];
    NSString *imgURLString = [dic[@"avatar"] stringByReplacingOccurrencesOfString:@"w.h" withString:@"156.220"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:YYPlaceholderImageName]];
    cell.textLabel.text = dic[@"cnm"];
    cell.detailTextLabel.text = dic[@"roles"];
    
    return cell;
}

@end
