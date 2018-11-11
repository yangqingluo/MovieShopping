//
//  YYViewPublic.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYViewPublic.h"
#import "YYDefine.h"
#import "UIImage+Color.h"

@implementation YYViewPublic

//生成视图
UIButton *NewBackButton(UIColor *color) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *i = [UIImage imageNamed:@"nav_back"];
    if (color) {
        i = [i imageWithColor:color];
    }
    [btn setImage:i forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 64, 44)];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    return btn;
}

UIButton *NewRightButton(UIImage *image, UIColor *color) {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(screen_width - 64, 0, 64, 44)];
    if (color) {
        image = [image imageWithColor:color];
    }
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    return btn;
}

UIButton *NewTextButton(NSString *title, UIColor *textColor) {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(screen_width - 64, 0, 64, 44)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:appButtonTitleFontSize];
    return btn;
}

UILabel *NewLabel(CGRect frame, UIColor *textColor, UIFont *font, NSTextAlignment alignment) {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor ? textColor : YYTextColor;
    label.font = font ? font : [UIFont systemFontOfSize:appLabelFontSize];
    label.textAlignment = alignment;
    return label;
}

UIView *NewSeparatorLine(CGRect frame) {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = YYSeparatorColor;
    return lineView;
}

@end
