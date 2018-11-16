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
#import "UIImage+Color.h"
#import "YYCollectionView.h"
#import "YYLabel.h"
#import "Swift.h"

static NSString *cellID = @"cell_ticket";

@interface SeatTicketCell: UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) YYLabel *priceLabel;

@end

@implementation SeatTicketCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor clearColor];
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.image = [UIImage imageNamed:@"yy_ticket"];
        [self.contentView addSubview:_imageView];
        
        _nameLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0,  YYEdgeSmall, self.contentView.width, 16)];
        _nameLabel.textColor = YYTextColor;
        _nameLabel.font = [UIFont systemFontOfSize:YYLabelFontSize];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];

        _priceLabel = [[YYLabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom, self.width, 14)];
        _priceLabel.textColor = YYRedColor;
        _priceLabel.font = [UIFont systemFontOfSize:YYLabelFontSizeSmall];
        _priceLabel.textAlignment = self.nameLabel.textAlignment;
        [self.contentView addSubview:_priceLabel];
    }
    return self;
}

@end

@interface SeatViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) YYCollectionView *collectionView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *footerBtn;
@property (nonatomic, strong) YYSectionView *sectionView;

@property (nonatomic, copy) NSArray *selecetedSeats;
@property (nonatomic, strong) YYSection *sectionData;

@end

@implementation SeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sourceData[@"cinema_name"];
    [self.view addSubview:self.headerView];
    self.footerView.bottom = self.view.height;
    [self.view addSubview:self.footerView];
    
    [self.collectionView registerClass:[SeatTicketCell class] forCellWithReuseIdentifier:cellID];
    
    [self showHudInView:self.view hint:nil];
    __weak typeof(self) weakSelf = self;
    [[YYNetwork getInstance] POST:@21 parameters:@{@"cityId": [YYPublic getInstance].city.ID} headers:nil response:^(id response, NSError *error) {
        [weakSelf hideHud];
        if (error) {
            
        }
        else {
            YYResponse *result = [YYResponse mj_objectWithKeyValues:response];
            if (result.code == HTTP_SUCCESS) {
                weakSelf.sectionData = [YYSection mj_objectWithKeyValues:response[@"data"]];
                [weakSelf setUpSectionView];
            }
        }
    }];
}

- (void)setUpSectionView {
    CGRect frame = CGRectMake(0, self.headerView.bottom, [UIScreen mainScreen].bounds.size.width, self.footerView.top - self.headerView.bottom);
    __weak typeof(self) weakSelf = self;
    _sectionView = [[YYSectionView alloc] initWithFrame:frame data:self.sectionData actionBlock:^(NSArray *selecetedSeats, NSString *errorStr) {
        if (errorStr) {
            [weakSelf showMessage:errorStr];
        }
        else {
            weakSelf.selecetedSeats = selecetedSeats;
            [weakSelf updateFooterView];
        }
    }];
    _sectionView.backgroundColor = RGBA(0xf5, 0xf5, 0xf5, 1.0);
    [self.view addSubview:_sectionView];
}

- (void)updateFooterView {
    NSInteger count = self.selecetedSeats.count;
    self.footerBtn.enabled = count > 0;
    if (count) {
        CGFloat price = [self.scheduleData[@"price"] floatValue];
        [_footerBtn setTitle:[NSString stringWithFormat:@"%.1f元 确认选座", price * count] forState:UIControlStateNormal];
        if (!self.collectionView.superview) {
            [self.footerView addSubview:self.collectionView];
        }
        [self.collectionView reloadData];
    }
    else {
        [self.collectionView removeFromSuperview];
    }
}

- (void)sureBtnAction{
    
}

- (void)autoSelectBtnAction:(UIButton *)button {
    NSLog(@"自动选择%d人", button.tag + 1);
}

- (void)showMessage:(NSString *)message {
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
        img1.image = [UIImage imageNamed:@"choosable"];
        img1.centerY = 0.5 * m_view.height;
        [m_view addSubview:img1];
        
        UILabel *label1 = NewLabel(CGRectMake(img1.right, 0, 40, m_view.height), YYTextColor, [UIFont systemFontOfSize:YYLabelFontSizeSmall], NSTextAlignmentCenter);
        label1.text = @"可选";
        [m_view addSubview:label1];
        
        UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(label1.right + YYEdge, 0, 20, 20)];
        img2.image = [UIImage imageNamed:@"sold"];
        img2.centerY = 0.5 * m_view.height;
        [m_view addSubview:img2];
        
        UILabel *label2 = NewLabel(CGRectMake(img2.right, 0, 40, m_view.height), YYTextColor, [UIFont systemFontOfSize:YYLabelFontSizeSmall], NSTextAlignmentCenter);
        label2.text = @"已选";
        [m_view addSubview:label2];
        
        UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(label2.right + YYEdge, 0, 20, 20)];
        img3.image = [UIImage imageNamed:@"seat_best_area"];
        img3.centerY = 0.5 * m_view.height;
        [m_view addSubview:img3];
        
        UILabel *label3 = NewLabel(CGRectMake(img3.right, 0, 80, m_view.height), YYTextColor, [UIFont systemFontOfSize:YYLabelFontSizeSmall], NSTextAlignmentCenter);
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
        
        UILabel *label = NewLabel(CGRectMake(YYEdgeMiddle, 0, 70, 50), YYTextColor, [UIFont systemFontOfSize: 12], NSTextAlignmentLeft);
        label.text = @"推荐选座";
        [_footerView addSubview:label];
        
        CGFloat width = 50;
        for (int i = 0; i < 4; i++) {
            UIButton *btn = NewTextButton([NSString stringWithFormat:@"%d人", i + 1], YYTextColor);
            btn.frame = CGRectMake(label.right + i * width + i * 7, 0, width, 25);
            btn.titleLabel.font = label.font;
            btn.centerY = label.centerY;
            btn.layer.borderColor = RGBA(0x99, 0x99, 0x99, 1.0).CGColor;
            btn.layer.borderWidth = 1.0;
            btn.layer.cornerRadius = 2.0;
            btn.layer.masksToBounds = YES;
            [_footerView addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(autoSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        _footerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _footerView.width, 50)];
        _footerBtn.bottom = _footerView.height;
        [_footerBtn setTitle:@"请先选座" forState:UIControlStateDisabled];
        [_footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_footerBtn setTitleColor:YYLightWhiteColor forState:UIControlStateDisabled];
        [_footerBtn setBackgroundImage:[UIImage imageWithColor:YYRedColor] forState:UIControlStateNormal];
        [_footerBtn setBackgroundImage:[UIImage imageWithColor:YYLightRedColor] forState:UIControlStateDisabled];
        _footerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _footerBtn.enabled = NO;
        [_footerView addSubview:_footerBtn];
        [_footerBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

- (YYCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        _flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        _flowLayout.minimumInteritemSpacing = 10.0;
        _flowLayout.minimumLineSpacing = 10.0;
        
        _collectionView = [[YYCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selecetedSeats.count;
}

//定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, YYEdgeMiddle, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SeatTicketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    YYSectionSeat *seat = self.selecetedSeats[indexPath.row];
    cell.nameLabel.text = seat.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元", self.scheduleData[@"price"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YYSectionSeat *seat = self.selecetedSeats[indexPath.row];
    [self.sectionView removeSelection:seat];
}

@end
