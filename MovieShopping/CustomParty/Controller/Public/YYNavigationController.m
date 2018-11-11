//
//  YYNavigationController.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/10.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYNavigationController.h"
#import "YYPublic.h"

@interface YYNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation YYNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.interactivePopGestureRecognizer.delegate = self;
//        self.navigationBarHidden = true;
        [YYPublic getInstance].mainNav = self;
    }
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}

@end
