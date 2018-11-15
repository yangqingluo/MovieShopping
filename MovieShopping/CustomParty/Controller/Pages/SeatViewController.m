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

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *footerBtn;

/**按钮数组*/
@property (nonatomic, copy) NSArray *selecetedSeats;

@property (nonatomic, copy) NSDictionary *allAvailableSeats;//所有可选的座位

@property (nonatomic, strong) NSArray *seatsModelArray;

@end

@implementation SeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sourceData[@"cinema_name"];
    [self.view addSubview:self.headerView];
    self.footerView.bottom = self.view.height;
    [self.view addSubview:self.footerView];
    
    
    [self showHudInView:self.view hint:nil];
    __weak typeof(self) weakSelf = self;
    //模拟延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHud];
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"seats %u.plist", arc4random_uniform(5)] ofType:nil];
        //模拟网络加载数据
        NSDictionary *seatsDic = [NSDictionary dictionaryWithContentsOfFile:path];

        NSArray *seatsModelArray = [YYSeats mj_objectArrayWithKeyValuesArray:seatsDic[@"seats"]];
        weakSelf.seatsModelArray = seatsModelArray;

        //数据回来初始化选座模块
        [weakSelf initSelectionView:seatsModelArray];
    });
    
}
//创建选座模块
- (void)initSelectionView:(NSArray *)seatsModelArray {
    __weak typeof(self) weakSelf = self;
    YYSeatSelectionView *selectionView = [[YYSeatSelectionView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, [UIScreen mainScreen].bounds.size.width, self.footerView.top - self.headerView.bottom) seatsArray:seatsModelArray hallName:self.scheduleData[@"hall_name"]
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

-(void)sureBtnAction{
    if (!self.selecetedSeats.count) {
        [self showMessage:@"您还未选座"];
        return;
    }
    //验证是否落单
    if (![YYSeatButton verifySelectedSeatsWithAllAvailableSeats:self.allAvailableSeats seatsArray:self.seatsModelArray]) {
        [self showMessage:@"不能这样选择座位"];
    }else{
        [self showMessage:@"选座成功"];
    }
}

-(void)showMessage:(NSString *)message{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - getter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, YY_TOP_HEIGHT, self.view.width, 100)];
        
        UILabel *_nameLabel = NewLabel(CGRectMake(YYEdgeMiddle, 10, _headerView.width, 20), [UIColor blackColor], [UIFont systemFontOfSize:YYLabelFontSizeMiddle], NSTextAlignmentLeft);
        [_headerView addSubview:_nameLabel];
        
        UILabel *_infoLabel = NewLabel(CGRectMake(_nameLabel.left, _nameLabel.bottom + YYEdgeSmall, _headerView.width, 20), [UIColor darkGrayColor], [UIFont systemFontOfSize:YYLabelFontSize], NSTextAlignmentLeft);
        [_headerView addSubview:_infoLabel];
        
        [_headerView addSubview:NewSeparatorLine(CGRectMake(0, 60, _headerView.width, 0.5))];
        
        UIView *m_view = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 200, 40)];
        m_view.centerX = 0.5 * _headerView.width;
        [_headerView addSubview:m_view];
        
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        img1.image = [UIImage imageNamed:@"kexuan"];
        img1.centerY = 0.5 * m_view.height;
        [m_view addSubview:img1];
        
        UILabel *label1 = NewLabel(CGRectMake(img1.right, 0, 40, m_view.height), YYTextColor, [UIFont systemFontOfSize:YYLabelFontSizeSmall], NSTextAlignmentCenter);
        label1.text = @"可选";
        [m_view addSubview:label1];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(label1.right + YYEdge, 0, 20, 20)];
        img2.image = [UIImage imageNamed:@"yishou"];
        img2.centerY = 0.5 * m_view.height;
        [m_view addSubview:img2];
        
        UILabel *label2 = NewLabel(CGRectMake(img2.right, 0, 40, m_view.height), YYTextColor, [UIFont systemFontOfSize:YYLabelFontSizeSmall], NSTextAlignmentCenter);
        label2.text = @"已选";
        [m_view addSubview:label2];
        
        UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(label2.right + YYEdge, 0, 20, 20)];
        img3.image = [UIImage imageNamed:@"xuanzhong"];
        img3.centerY = 0.5 * m_view.height;
        [m_view addSubview:img3];
        
        UILabel *label3 = NewLabel(CGRectMake(img3.right, 0, 60, m_view.height), YYTextColor, [UIFont systemFontOfSize:YYLabelFontSizeSmall], NSTextAlignmentCenter);
        label3.text = @"最佳观影区";
        [m_view addSubview:label3];
        
        _nameLabel.text = self.filmData[@"show_name"];
        if (self.dateData) {
            _infoLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.dateData[@"show_date"], self.scheduleData[@"show_time"], self.scheduleData[@"show_version"]];
        }
        else {
            _infoLabel.text = [NSString stringWithFormat:@"%@ %@", self.scheduleData[@"show_time"], self.scheduleData[@"show_version"]];
        }
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
        _footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _footerView.width, 50)];
        _footerBtn.bottom = _footerView.height;
        [_footerBtn setTitle:@"请先选座" forState:UIControlStateNormal];
        _footerBtn.backgroundColor = YYRedColor;
        [_footerView addSubview:_footerBtn];
        [_footerBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

@end
