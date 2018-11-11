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

#define YYSeparatorColor            RGBA(0xdb, 0xdb, 0xdb, 1.0)
#define YYTextColor                 RGBA(0x21, 0x21, 0x21, 1.0)
#define YYMainColor                 RGBA(0xff, 0x00, 0x00, 1.0)

#define YYRedColor                  RGBA(0xff, 0x00, 0x00, 1.0)
#define YYLightRedColor             RGBA(0xff, 0x6b, 0x54, 1.0)
#define YYGreenColor                RGBA(0x22, 0xb5, 0x89, 1.0)
#define YYLightGreenColor           RGBA(0xa5, 0xd5, 0x32, 1.0)
#define YYBlueColor                 RGBA(0x00, 0xa4, 0xff, 1.0)
#define YYLightBlueColor            RGBA(0x3f, 0xcc, 0xe9, 1.0)
#define YYDarkOrangeColor           RGBA(0xff, 0x8c, 0x00, 1.0)
#define YYLightWhiteColor           RGBA(0xe0, 0xe0, 0xe0, 1.0)
#define YYSilverColor               RGBA(0xc0, 0xc0, 0xc0, 1.0)

#define YYButtonTitleFontSizeSmall  12.0
#define YYButtonTitleFontSize       14.0
#define YYLabelFontSizeSmall        12.0
#define YYLabelFontSize             14.0
#define YYLabelFontSizeMiddle       16.0

#define YYEdgeSmall                   5.0
#define YYEdge                        10.0
#define YYEdgeMiddle                  15.0
#define YYEdgeBig                     20.0
#define YYEdgeHuge                    30.0

#define YYPlaceholderImageName      @"sd_placeholder"

#endif /* YYDefine_h */
