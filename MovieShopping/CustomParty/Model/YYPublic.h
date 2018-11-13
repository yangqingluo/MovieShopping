//
//  YYPublic.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYNavigationController.h"
#import "YYType.h"

@interface YYPublic : NSObject

+ (YYPublic *)getInstance;

@property (nonatomic, weak) YYNavigationController *mainNav;
@property (nonatomic, strong) YYCity *city;

YYResponse *APIData(NSNumber *number);

@end
