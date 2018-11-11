//
//  YYDefine.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#ifndef YYDefine_h
#define YYDefine_h

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#define YYWEAKSELF typeof(self) __weak weakself = self;

#define RGBA(R, G, B, A) [UIColor colorWithRed:R / 255.f green:G / 255.f blue:B / 255.f alpha:A]

#define YYiosVersion      ([[[UIDevice currentDevice] systemVersion] floatValue])

#define YYIsX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define YY_STATUS_BAR_HEIGHT            (YYIsX ? 44.0 : 20.0)
#define YY_NAVIGATION_BAR_HEIGHT        44.0
#define YY_TAB_BAR_HEIGHT               (YYIsX ? 83.0 : 49.0)

#define YYSeparatorColor           RGBA(0xdb, 0xdb, 0xdb, 1.0)
#define YYTextColor                RGBA(0x21, 0x21, 0x21, 1.0)

#define appButtonTitleFontSizeSmall  14.0
#define appButtonTitleFontSize       16.0
#define appLabelFontSizeSmall        14.0
#define appLabelFontSize             16.0
#define appLabelFontSizeMiddle       18.0
#define appSeparaterLineSize         0.5//分割线尺寸
#define appPageSize                  10//获取分页数据时分页size

#endif /* YYDefine_h */
