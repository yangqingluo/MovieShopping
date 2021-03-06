/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "YYViewController+HUD.h"
#import "MBProgressHUD+Add.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [MBProgressHUD showMessage:hint toView:view];
    [self setHUD:HUD];
}

- (void)showHintInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.userInteractionEnabled = NO;
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = hint;
    HUD.detailsLabel.text= hint;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
    
    [HUD hideAnimated:YES afterDelay:2.0];
}

- (void)showHint:(NSString *)hint {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
//    hud.labelText = hint;
    hud.detailsLabel.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, 200);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud {
    [[self HUD] hideAnimated:YES];
}

@end
