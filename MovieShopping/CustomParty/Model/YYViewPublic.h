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

static NSString *filmString = @"{\"movieList\":[{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"詹姆斯·卡梅隆\",\"LeadingRole\":\"汤姆·哈迪,米歇尔·威廉姆斯,里兹·阿迈德\",\"BackgroundPicture\":\"http://p7.qhmsg.com/t01de9a61e79f600505.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"毒液：致命守护者\",\"OpenDay\":\"2018-11-09\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"詹姆斯·卡梅隆\",\"LeadingRole\":\"郑伊健,贾青,于荣光\",\"BackgroundPicture\":\"http://p5.qhmsg.com/t01bd4c5321d4ff62d1.jpg?size=300x400\",\"ShowMark\":\"IMAX 2D\",\"ShowName\":\"三国杀·幻\",\"OpenDay\":\"2018-11-09\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"詹姆斯·卡梅隆\",\"LeadingRole\":\"比蒂·埃德蒙森,艾德·斯克林,汤姆·班尼特\",\"BackgroundPicture\":\"http://p3.qhmsg.com/t0179b3505c849aa2c0.jpg?size=300x400\",\"ShowName\":\"我的冤家是条狗\",\"OpenDay\":\"2018-11-09\",\"BuyPre\": 1},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"詹姆斯·卡梅隆\",\"LeadingRole\":\"高山南,山口胜平,山崎和佳奈\",\"BackgroundPicture\":\"http://p2.qhmsg.com/t012a15d849652372cd.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"名侦探柯南：零的执行人\",\"OpenDay\":\"2018-11-09\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"詹姆斯·卡梅隆\",\"LeadingRole\":\"周迅,秦昊,杜江\",\"BackgroundPicture\":\"http://p7.qhmsg.com/t01f9de129513d458d9.jpg?size=300x400\",\"ShowMark\":\"\",\"ShowName\":\"你好，之华\",\"OpenDay\":\"2018-11-09\"},{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"詹姆斯·卡梅隆\",\"LeadingRole\":\"埃迪·雷德梅恩,凯瑟琳·沃特森,艾莉森·萨多尔\",\"BackgroundPicture\":\"http://p0.meituan.net/w.h/movie/5bd4ec1cded88c7cd48f0b58589bd505610552.jpg\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"神奇动物：格林德沃之罪\",\"OpenDay\":\"2018-11-16\",\"BuyPre\": 1}]}";

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
