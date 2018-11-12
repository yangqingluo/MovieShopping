//
//  MovieController.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "MovieController.h"
#import "MovieHomeSubVC.h"
#import "MovieFilmSubVC.h"
#import "MovieCinemaSubVC.h"
#import "UIImage+Color.h"
#import "GF_CityListViewController.h"

@interface MovieController ()

@property (nonatomic, strong) NSMutableArray *vcArray;


@end

@implementation MovieController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationItem.leftBarButtonItems = @[self.navigationItem.leftBarButtonItem, [[UIBarButtonItem alloc] initWithTitle:@"成都" style:UIBarButtonItemStylePlain target:self action:@selector(cityBtnAction)]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnAction)];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    segment.tintColor = [UIColor redColor];
    NSArray *titleArray = @[@"首页", @"电影", @"影院"];
    for (NSInteger i = 0; i < self.vcArray.count; i++) {
        [segment insertSegmentWithTitle:titleArray[i] atIndex:i animated:NO];
    }
    [segment addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    [self segmentedControlAction:segment];
}

- (void)backBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cityBtnAction {
    GF_CityListViewController *cityListVC = [GF_CityListViewController new];
    
    [cityListVC changeCityName:^(NSString *cityName) {
        
//        sender.title = cityName;
//
//        [self getMovieDatas:cityName];
    }];    
    [self.navigationController pushViewController:cityListVC animated:YES];
}

- (void)searchBtnAction {
    
}

- (void)segmentedControlAction:(UISegmentedControl *)segment {
    for (NSInteger i = 0; i < self.vcArray.count; i++) {
        UIViewController *subVC = self.vcArray[i];
        if (i == segment.selectedSegmentIndex) {
           [self.view addSubview:subVC.view];
        }
    }
}

#pragma mark - getter
- (NSMutableArray *)vcArray {
    if (!_vcArray) {
        _vcArray = [NSMutableArray arrayWithCapacity:3];
        [_vcArray addObject:[MovieHomeSubVC new]];
        [_vcArray addObject:[MovieFilmSubVC new]];
        [_vcArray addObject:[MovieCinemaSubVC new]];
    }
    return _vcArray;
}


@end
