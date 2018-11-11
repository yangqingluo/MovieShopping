//
//  YYBaseViewController.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYBaseViewController.h"
#import "YYDefine.h"

@interface YYBaseViewController () 

@end

@implementation YYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
