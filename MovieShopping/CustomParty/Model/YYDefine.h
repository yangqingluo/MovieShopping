//
//  YYDefine.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#ifndef YYDefine_h
#define YYDefine_h

#define YYScreenWidth [UIScreen mainScreen].bounds.size.width
#define YYScreenHeight [UIScreen mainScreen].bounds.size.height

#define YYWEAKSELF typeof(self) __weak weakself = self;

#define RGBA(R, G, B, A) [UIColor colorWithRed:R / 255.f green:G / 255.f blue:B / 255.f alpha:A]

#define YYiosVersion      ([[[UIDevice currentDevice] systemVersion] floatValue])

#define YYIsX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define YY_STATUS_BAR_HEIGHT            (YYIsX ? 44.0 : 20.0)
#define YY_NAVIGATION_BAR_HEIGHT        44.0
#define YY_TAB_BAR_HEIGHT               (YYIsX ? 83.0 : 49.0)

#define YYSeparatorColor           RGBA(0xdb, 0xdb, 0xdb, 1.0)
#define YYTextColor                RGBA(0x21, 0x21, 0x21, 1.0)

#define YYButtonTitleFontSizeSmall  14.0
#define YYButtonTitleFontSize       16.0
#define YYLabelFontSizeSmall        14.0
#define YYLabelFontSize             16.0
#define YYLabelFontSizeMiddle       18.0

#define YYEdgeSmall                   5.0
#define YYEdge                        10.0
#define YYEdgeMiddle                  15.0
#define YYEdgeBig                     20.0
#define YYEdgeHuge                    30.0

#endif /* YYDefine_h */
