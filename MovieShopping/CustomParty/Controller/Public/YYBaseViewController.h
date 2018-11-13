//
//  YYBaseViewController.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYPublic.h"

@interface YYBaseViewController : UIViewController

@property (nonatomic, copy) NSDictionary *sourceData;

- (void)backBtnAction;

@end
