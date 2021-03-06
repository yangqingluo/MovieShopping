//
//  UIImage+Color.h
//  UIImage+Categories
//
//  Created by lisong on 16/9/4.
//  Copyright © 2016年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/** 根据颜色生成纯色图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

/** 生成虚线边框图片 */
+ (UIImage *)dottedLineImageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

/** 改变图片颜色 */
- (UIImage *)imageWithColor:(UIColor *)color;

/** 取图片某一像素的颜色 */
- (UIColor *)colorAtPixel:(CGPoint)point;

/** 获得灰度图 */
- (UIImage *)convertToGrayImage;

@end
