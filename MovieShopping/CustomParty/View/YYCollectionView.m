//
//  YYCollectionView.m
//  MovieShopping
//
//  Created by 7kers on 2018/11/11.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "YYCollectionView.h"

@implementation YYCollectionView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL result = [super pointInside:point withEvent:event];
    if (result) {
        NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
        if (indexPath) {
            return YES;
        }
    }
    return NO;
}

@end
