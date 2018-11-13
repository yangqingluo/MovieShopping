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
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(YYScreenWidth - 64, 0, 64, 44)];
    if (color) {
        image = [image imageWithColor:color];
    }
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    return btn;
}

UIButton *NewTextButton(NSString *title, UIColor *textColor) {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(YYScreenWidth - 64, 0, 64, 44)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:YYButtonTitleFontSize];
    return btn;
}

UILabel *NewLabel(CGRect frame, UIColor *textColor, UIFont *font, NSTextAlignment alignment) {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor ? textColor : YYTextColor;
    label.font = font ? font : [UIFont systemFontOfSize:YYLabelFontSize];
    label.textAlignment = alignment;
    return label;
}

UIView *NewSeparatorLine(CGRect frame) {
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = YYSeparatorColor;
    return lineView;
}

//文本尺寸
CGSize textSizeWithStringInContentWidth(NSString *text, UIFont *font,  CGFloat width) {
    return textSizeWithStringInContentSize(text, font, CGSizeMake(width, MAXFLOAT));
}

CGSize textSizeWithStringInContentHeight(NSString *text, UIFont *font, CGFloat height) {
    return textSizeWithStringInContentSize(text, font, CGSizeMake(MAXFLOAT, height));
}

CGSize textSizeWithStringInContentSize(NSString *text, UIFont *font, CGSize size) {
    NSMutableParagraphStyle *paragraphStyle= [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = 0;
    
    NSStringDrawingOptions drawOptions = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attibutes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    return [text boundingRectWithSize:size options:drawOptions attributes:attibutes context:nil].size;
}

void adjustLabelWidth(UILabel *label) {
    adjustLabelWidthWithEdge(label, 0.0);
}

void adjustLabelWidthWithEdge(UILabel *label, CGFloat edge) {
    label.width = ceil(textSizeWithStringInContentHeight(label.text, label.font, label.height).width) + 2 * edge;//根据苹果官方文档介绍，计算出来的值比实际需要的值略小，故需要对其向上取整，这样子获取的高度才是我们所需要的。
}

void adjustLabelHeight(UILabel *label) {
    label.height = ceil(textSizeWithStringInContentWidth(label.text, label.font, label.height).height);
}

void adjustLabelSizeWithEdge(UILabel *label, CGSize size, CGFloat edge) {
    CGSize m_size = textSizeWithStringInContentSize(label.text, label.font, size);
    label.width = ceil(m_size.width) + 2 * edge;
    label.height = ceil(m_size.height);
}

@end
