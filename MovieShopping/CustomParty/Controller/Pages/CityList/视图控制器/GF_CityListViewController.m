//
//  GF_CityListViewController.m
//  CityListDemo
//
//  Created by GaoFei on 16/3/19.
//  Copyright © 2016年 YF_S. All rights reserved.
//

#import "GF_CityListViewController.h"
#import "GF_LocateHeaderView.h"
#import "MBProgressHUD.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GF_CityListViewController (){
    NSMutableDictionary* _cities;
    GF_LocateHeaderView* _headerView;
}

@property (nonatomic,retain) NSMutableArray *keys;

@end

@implementation GF_CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bringTableViewUnderNavigation:YES];
    self.title = @"城市选择";
    _keys = [[NSMutableArray alloc] init];
    
    [self getCityData];//获取城市信息
    [self createTableView];//创建表格
}

#pragma mark 获取城市信息
-(void)getCityData
{
    //读取plist文件
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    //所有城市
    _cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //所有城市分类的首字母，排序
    [_keys addObjectsFromArray:[[_cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}
#pragma mark 创建UI
- (void)createTableView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.sectionIndexColor = [UIColor blackColor];//设置表格所用颜色
    
    _headerView = [[GF_LocateHeaderView alloc] initWithSource:(NSMutableArray *)[[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"selectCity"] allKeys]];//作为表格头的数据源
    __weak GF_CityListViewController* wSeaf = self;
    [_headerView setSelectCity:^(NSString *city) {
        [wSeaf saveCityHistory:city];
    }];
    //表格头
    [self.tableView setTableHeaderView:_headerView];
    
}
#pragma mark 保存历史选中城市的记录
- (void)saveCityHistory:(NSString*)city
{
//    NSMutableArray* selectCitys = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"] mutableCopy];
    
    NSDictionary *cityDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"selectCity"];
    
    NSMutableDictionary *selectCitys = [NSMutableDictionary dictionaryWithDictionary:cityDic];
    
//    NSArray* cityArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"];
//    
//    NSMutableArray *selectCitys = [NSMutableArray arrayWithArray:cityArr];
    
    if (selectCitys == nil) {
        NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:city forKey:city];
        [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:@"selectCity"];
    }else{
        
        if (selectCitys.count < 6) {
            [selectCitys setObject:city forKey:city];
            [[NSUserDefaults standardUserDefaults] setObject:selectCitys forKey:@"selectCity"];
        }else{
            [selectCitys removeObjectForKey:[[selectCitys allKeys] firstObject]];
            [selectCitys setObject:city forKey:city];
            [[NSUserDefaults standardUserDefaults] setObject:selectCitys forKey:@"selectCity"];
        }

        
//        for (NSString * cityName in [[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"]) {
//            
//            if ([cityName isEqualToString:city]) {
//                
//                if (selectCitys.count < 6) {
//                    [selectCitys addObject:city];
//                    [[NSUserDefaults standardUserDefaults] setObject:selectCitys forKey:@"selectCity"];
//                }else{
//                    [selectCitys removeObjectAtIndex:0];
//                }
//
//            }
//        }
    }
    //    if ([self.delegate respondsToSelector:@selector(selectCity:)]) {
    //        [self.delegate selectCity:city];
    //
    //    }
    
    _block(city);
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* array = _cities[_keys[section]];
    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    NSArray* array = _cities[_keys[indexPath.section]];
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textColor = UIColorFromRGB(0x666666);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    bgView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-30, 32)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = _keys[section];
    label.textColor = UIColorFromRGB(0x666666);
    [bgView addSubview:label];
    return bgView;
}
//显示表格右边索引集合
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _keys;
}

//选中索引回调方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.mode = MBProgressHUDModeCustomView;
    hub.label.font = [UIFont systemFontOfSize:16];
    hub.label.text = title;
    hub.minShowTime = 0.5;
    [self.view addSubview:hub];
    [hub showAnimated:YES];
    [hub hideAnimated:YES afterDelay:0.5];
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* cityArray = _cities[_keys[indexPath.section]];
    [self saveCityHistory:cityArray[indexPath.row]];
    
}

-(void)changeCityName:(changeCityName)block{
    
    _block = block;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
