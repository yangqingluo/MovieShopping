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

@interface MovieController ()

@property (nonatomic, strong) NSMutableArray *vcArray;


@end

@implementation MovieController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationItem.leftBarButtonItems = @[self.navigationItem.leftBarButtonItem, [[UIBarButtonItem alloc] initWithTitle:@"成都" style:UIBarButtonItemStylePlain target:self action:@selector(cityBtnAction)]];
    NSLog(@"%f", self.navigationController.navigationBar.frame.origin.y);
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    segment.tintColor = [UIColor redColor];
    NSArray *titleArray = @[@"首页",@"电影",@"影院"];
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
