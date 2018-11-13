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

//static NSString *filmString = @"{\"movieList\":[{\"Id\":42964,\"Remark\":\"9.7\",\"Director\":\"鲁本·弗雷斯彻\",\"LeadingRole\":\"汤姆·哈迪,米歇尔·威廉姆斯,里兹·阿迈德\",\"BackgroundPicture\":\"http://p7.qhmsg.com/t01de9a61e79f600505.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"毒液：致命守护者\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\",\"Wish\":\"25380\",\"Description\":\"蜘蛛侠最强劲敌“毒液”强势来袭！曾主演《敦刻尔克》《盗梦空间》等口碑大片的肌肉型男汤姆·哈迪在本片中饰演“毒液”的宿主–埃迪·布洛克。身为记者的埃迪在调查生命基金会老板卡尔顿·德雷克（里兹·阿迈德饰）的过程中，事业遭受重创，与未婚妻安妮·韦英（米歇尔·威廉姆斯饰）的关系岌岌可危，并意外被外星共生体入侵，历经挣扎对抗，最终成为拥有强大超能力，无人可挡的“毒液”。影片极具震撼的视效制作，颠覆想象的展示了“毒液”的变身过程，并将其酷炫的外形和强大的技能呈现的淋漓尽致。\"},{\"Id\":1194411,\"Remark\":\"6.7\",\"Director\":\"吕柯憬\",\"LeadingRole\":\"郑伊健,贾青,于荣光\",\"BackgroundPicture\":\"http://p5.qhmsg.com/t01bd4c5321d4ff62d1.jpg?size=300x400\",\"ShowMark\":\"IMAX 2D\",\"ShowName\":\"三国杀·幻\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\",\"Wish\":\"25380\",\"Description\":\"两件神秘锦囊， 带出充斥着主忠反内“英雄门”传承的惊人秘密， 而当揭开这些表象时，另一个关于深爱与成全的纠结故事开始展露它的真实面目。\"},{\"Id\":1238758,\"Remark\":\"8.7\",\"Director\":\"Mandie Fletcher\",\"LeadingRole\":\"比蒂·埃德蒙森,艾德·斯克林,汤姆·班尼特\",\"BackgroundPicture\":\"http://p3.qhmsg.com/t0179b3505c849aa2c0.jpg?size=300x400\",\"ShowName\":\"我的冤家是条狗\",\"OpenDay\":\"2018-11-09\",\"BuyPre\": 1,\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\",\"Wish\":\"25380\"},{\"Id\":1225632,\"Remark\":\"8.2\",\"Director\":\"立川让\",\"LeadingRole\":\"高山南,山口胜平,山崎和佳奈\",\"BackgroundPicture\":\"http://p2.qhmsg.com/t012a15d849652372cd.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"名侦探柯南：零的执行人\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\",\"Wish\":\"25380\",\"Description\":\"某年的5月1日，最新一届东京首脑峰会在伫立于东京湾的全新场馆“海洋边际（Edge of Ocean）”中召开。是日，总计约2.2万名警察出动，执行峰会期间的安保工作。然而就在开幕式当天，刺耳的爆炸声撕裂了“海洋边际”内外的祥和宁静。在众多警务人员当中，从属于有权指挥全国公安警察、警察厅秘密组织“零课”的安室透（古谷彻 配音）引起了柯南（高山南 配音）的注意。安室行事诡秘谨慎，虽然符合他的身份，可是某种不协调感似乎正透露他心中的秘密。大爆炸引起的骚动尚未褪去，而根据现场的证物和指纹，原本拥有警察身份的毛利小五郎（小山力也 配音）则被视为犯罪嫌疑人。围绕对小五郎的抓捕，柯南与安室展开连番的角力。在此期间，柯南听说一段关于安室的旧闻。当年安室在追捕某嫌疑犯时，曾经迫使对方自杀。当检方准备对小五郎提起诉讼时，高度戒备的东京又接二连三发生多起恐怖爆炸袭击事件。警方疲于奔命，柯南则在纷乱的头绪中发现些许线索，东京首脑峰会开幕的日子刚好是大型无人探索航空器“天鹅”从火星返回地球的日子。这两个时间到底有什么关联？而神秘莫测的安室透究竟是敌人？还是伙伴？真实？正义？爱？不择手段的绝密任务，以冷酷无情的手段泼下了复仇之雨，只为心中那笃定要去守护的东西……\"},{\"Id\":1216326,\"Remark\":\"7.5\",\"Director\":\"岩井俊二\",\"LeadingRole\":\"周迅,秦昊,杜江\",\"BackgroundPicture\":\"http://p7.qhmsg.com/t01f9de129513d458d9.jpg?size=300x400\",\"ShowMark\":\"\",\"ShowName\":\"你好，之华\",\"OpenDay\":\"2018-11-09\",\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\",\"Wish\":\"25380\"},{\"Id\":577564,\"Remark\":\"6.0\",\"Director\":\"大卫·耶茨\",\"LeadingRole\":\"埃迪·雷德梅恩,凯瑟琳·沃特森,艾莉森·萨多尔\",\"BackgroundPicture\":\"http://p9.qhmsg.com/t012248331242b56080.jpg?size=300x400\",\"ShowMark\":\"IMAX 3D\",\"ShowName\":\"神奇动物：格林德沃之罪\",\"OpenDay\":\"2018-11-16\",\"BuyPre\": 1,\"Duration\":\"123\",\"Type\":\"剧情/喜剧\",\"Country\":\"中国大陆\",\"Wish\":\"25380\"}]}";
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
CGSize textSizeWithStringInContentSize(NSString *text, UIFont *font, CGSize size);
void adjustLabelWidth(UILabel *label);
void adjustLabelWidthWithEdge(UILabel *label, CGFloat edge);
void adjustLabelHeight(UILabel *label);
void adjustLabelSizeWithEdge(UILabel *label, CGSize size, CGFloat edge);

@end
