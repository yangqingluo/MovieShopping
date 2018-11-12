//
//  GF_CityTableViewCell.h
//  CityListDemo
//
//  Created by GaoFei on 16/3/19.
//  Copyright © 2016年 YF_S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GF_CityTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray* itemsArray;

@property (nonatomic,copy) void(^selectCell)(NSString* city);

@end
