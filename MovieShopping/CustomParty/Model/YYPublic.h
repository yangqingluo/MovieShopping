//
//  YYPublic.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYNavigationController.h"
#import "YYViewPublic.h"
#import "YYViewController+HUD.h"
#import "YYNetwork.h"
#import "YYType.h"

@interface YYPublic : NSObject

+ (YYPublic *)getInstance;

@property (nonatomic, weak) YYNavigationController *mainNav;
@property (nonatomic, strong) YYCity *city;
@property (nonatomic, strong) NSString *token;

@end
