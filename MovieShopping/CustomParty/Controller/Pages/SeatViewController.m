//
//  SeatViewController.m
//  MovieSeat
//
//  Created by 7kers on 2018/11/4.
//  Copyright © 2018年 7kers. All rights reserved.
//

#import "SeatViewController.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "Swift.h"
#import "YYSeat.h"

@interface SeatViewController ()

/**按钮数组*/
@property (nonatomic, copy) NSArray *selecetedSeats;

@property (nonatomic, copy) NSDictionary *allAvailableSeats;//所有可选的座位

@property (nonatomic, strong) NSArray *seatsModelArray;

@end

@implementation SeatViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = self.sourceData[@"show_name"];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    HUD.tintColor = [UIColor blackColor];
    [self.view addSubview:HUD];
    [HUD showAnimated:YES];
    __weak typeof(self) weakSelf = self;
    
    //模拟延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"seats %u.plist", arc4random_uniform(5)] ofType:nil];
        //模拟网络加载数据
        NSDictionary *seatsDic = [NSDictionary dictionaryWithContentsOfFile:path];

        NSArray *seatsModelArray = [YYSeats mj_objectArrayWithKeyValuesArray:seatsDic[@"seats"]];
        [HUD hideAnimated:YES];
        weakSelf.seatsModelArray = seatsModelArray;

        //数据回来初始化选座模块
        [weakSelf initSelectionView:seatsModelArray];
        [weakSelf setupSureBtn];
//        KC20Hf3dfsf
    });
    
}
//创建选座模块
- (void)initSelectionView:(NSMutableArray *)seatsModelArray {
    __weak typeof(self) weakSelf = self;
    YYSeatSelectionView *selectionView = [[YYSeatSelectionView alloc] initWithFrame:CGRectMake(0, 100,[UIScreen mainScreen].bounds.size.width, 400) seatsArray:seatsModelArray     hallName:@"七号杜比全景声4K厅"
    actionBlock:^(NSArray *selecetedSeats, NSDictionary *allAvailableSeats, NSString *errorStr) {
        NSLog(@"=====%zd个选中按钮===========%zd个可选座位==========errorStr====%@=========",selecetedSeats.count,allAvailableSeats.count,errorStr);
        if (errorStr) {
            //错误信息
            [self showMessage:errorStr];
        }
        else {
            //储存选好的座位及全部可选座位
            weakSelf.allAvailableSeats = allAvailableSeats;
            weakSelf.selecetedSeats = selecetedSeats;
        }
    }];
    [self.view addSubview:selectionView];
}



-(void)setupSureBtn{

    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定选座" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setBackgroundColor:[UIColor yellowColor]];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.frame = CGRectMake(200, 550, 100, 50);
    [self.view addSubview:sureBtn];
}

-(void)sureBtnAction{
    if (!self.selecetedSeats.count) {
        [self showMessage:@"您还未选座"];
        return;
    }
    //验证是否落单
    if (![YYSeatButton verifySelectedSeatsWithAllAvailableSeats:self.allAvailableSeats seatsArray:self.seatsModelArray]) {
        [self showMessage:@"落单"];
    }else{
        [self showMessage:@"选座成功"];
    }
}
-(void)showMessage:(NSString *)message{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
