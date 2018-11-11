//
//  YYViewPublic.h
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYDefine.h"
#import "MJExtension.h"
#import "UIView+KGViewExtend.h"

static NSString *filmString = @"{\"movieList\":[{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"鲁本·弗雷斯彻\",\"LeadingRole\":\"汤姆·哈迪,米歇尔·威廉姆斯,里兹·阿迈德\",\"BackgroundPicture\":\"http://p7.qhmsg.com/t01de9a61e79f600505.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"毒液：致命守护者\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"吕柯憬\",\"LeadingRole\":\"郑伊健,贾青,于荣光\",\"BackgroundPicture\":\"http://p5.qhmsg.com/t01bd4c5321d4ff62d1.jpg?size=300x400\",\"ShowMark\":\"IMAX 2D\",\"ShowName\":\"三国杀·幻\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"Mandie Fletcher\",\"LeadingRole\":\"比蒂·埃德蒙森,艾德·斯克林,汤姆·班尼特\",\"BackgroundPicture\":\"http://p3.qhmsg.com/t0179b3505c849aa2c0.jpg?size=300x400\",\"ShowName\":\"我的冤家是条狗\",\"OpenDay\":\"2018-11-09\",\"BuyPre\": 1,\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"立川让\",\"LeadingRole\":\"高山南,山口胜平,山崎和佳奈\",\"BackgroundPicture\":\"http://p2.qhmsg.com/t012a15d849652372cd.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"名侦探柯南：零的执行人\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"岩井俊二\",\"LeadingRole\":\"周迅,秦昊,杜江\",\"BackgroundPicture\":\"http://p7.qhmsg.com/t01f9de129513d458d9.jpg?size=300x400\",\"ShowMark\":\"\",\"ShowName\":\"你好，之华\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"大卫·耶茨\",\"LeadingRole\":\"埃迪·雷德梅恩,凯瑟琳·沃特森,艾莉森·萨多尔\",\"BackgroundPicture\":\"http://p9.qhmsg.com/t012248331242b56080.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"神奇动物：格林德沃之罪\",\"OpenDay\":\"2018-11-16\",\"BuyPre\": 1,\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\"}]}";
static NSString *cinemaString = @"{\"Cinemas\":[{\"Id\":42964,\"CinemaName\":\"成都万达影城金沙广场店\",\"Address\":\"青羊区清江中路59号文化宫3F\",\"Price\":\"27.9\"},{\"Id\":42964,\"CinemaName\":\"太平洋影城（西村店）\",\"Address\":\"青羊区清江中路59号文化宫3F\",\"Price\":\"19.9\"},{\"Id\":42964,\"CinemaName\":\"耀莱成龙国际影城(西红门店)\",\"Address\":\"大兴区欣旺北大街8号鸿坤广场6层（地铁4号线西红门站Ｂ口向东４００米路北）\",\"Price\":\"26.9\"},{\"Id\":42964,\"CinemaName\":\"耀莱成龙国际影城(花乡店)\",\"Address\":\"丰台区南四环西路76号北京花乡奥莱村第十三号楼三层四层\",\"Price\":\"27.9\"},{\"Id\":42964,\"CinemaName\":\"耀莱成龙国际影城(丽泽桥店)\",\"Address\":\"丰台区西三环南路甲27号居然之家5层\",\"Price\":\"57.6\"},{\"Id\":42964,\"CinemaName\":\"耀莱成龙国际影城(花乡店)\",\"Address\":\"丰台区南四环西路76号北京花乡奥莱村第十三号楼三层四层\",\"Price\":\"27.9\"},{\"Id\":42964,\"CinemaName\":\"星典影城六里桥店(原星空影城)\",\"Address\":\"丰台区西三环南路甲27号居然之家5层\",\"Price\":\"57.6\"},{\"Id\":42964,\"CinemaName\":\"耀莱成龙国际影城(花乡店)\",\"Address\":\"丰台区西三环南路10号月恒正大新生活广场三层\",\"Price\":\"27.9\"},{\"Id\":42964,\"CinemaName\":\"咪咚影院(良乡店)\",\"Address\":\"房山区拱辰南大街7号院1号楼良辰百货4层\",\"Price\":\"57.6\"}]}";

@interface YYViewPublic : NSObject

//生成视图
UIButton *NewBackButton(UIColor *color);
UIButton *NewRightButton(UIImage *image, UIColor *color);
UIButton *NewTextButton(NSString *title, UIColor *textColor);
UILabel *NewLabel(CGRect frame, UIColor *textColor, UIFont *font, NSTextAlignment alignment);
UIView *NewSeparatorLine(CGRect frame);

//文本尺寸
CGSize textSizeWithStringInContentWidth(NSString *text, UIFont *font,  CGFloat width);
CGSize textSizeWithStringInContentHeight(NSString *text, UIFont *font,  CGFloat height);
void adjustLabelWidth(UILabel *label);
void adjustLabelWidthWithEdge(UILabel *label, CGFloat edge);
void adjustLabelHeight(UILabel *label);

@end
