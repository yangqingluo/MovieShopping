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
