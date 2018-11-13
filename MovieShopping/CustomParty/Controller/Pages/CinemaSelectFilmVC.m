//
//  CinemaSelectFilmVC.m
//  MovieShopping
//
//  Created by naver on 2018/11/13.
//  Copyright © 2018 yang. All rights reserved.
//

#import "CinemaSelectFilmVC.h"
#import "CinemaForFilmCell.h"

@interface CinemaSelectFilmVC ()

@property (nonatomic, copy) NSArray *filmList;

@end

@implementation CinemaSelectFilmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sourceData[@"cinema_name"];
    [self bringTableViewUnderNavigation:YES];
    [self updateTableViewHeader];
    [self beginRefreshing];
}

#pragma mark - Networking
- (void)pullBaseListData:(BOOL)isReset {
    [self showHudInView:self.view hint:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:0.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            YYResponse *response = APIData(@10);
            if (response.code == HTTP_SUCCESS) {
                self.filmList = response.data.items;
            }
            [self endRefreshing];
            [self updateSubviews];
        });
    });
}

#pragma mark - getter

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filmList.count ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_cinema_film";
    CinemaForFilmCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSString *nibName = NSStringFromClass([CinemaForFilmCell class]);
        [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:ID];
        cell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
    }
    if (!cell.browser) {
        cell.browser = [[YYMovieBrowser alloc] initWithFrame:CGRectMake(0, 75, self.view.width, 125) movies:self.filmList currentIndex:0];
        [cell.contentView addSubview:cell.browser];
        cell.browser.delegate = cell;
    }
    NSDictionary *dic = self.sourceData;
    cell.nameLabel.text = dic[@"cinema_name"];
    cell.addressLabel.text = dic[@"address"];
    return cell;
}

@end
