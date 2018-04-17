//
//  UIView+WLCornerRadius.m
//  CeXi
//
//  Created by Rice on 2017/5/23.
//  Copyright © 2017年 wangLiang. All rights reserved.
//

#import "UIView+WLCornerRadius.h"

@implementation UIView (WLCornerRadius)
-(void)cornerRadius_wl{
//    self.layer.shouldRasterize = YES;

    self.layer.cornerRadius  = 5;
    self.clipsToBounds = YES;
}
-(void)cornerRadius_wl:(CGFloat)x{
//    self.layer.shouldRasterize = YES;

    self.layer.cornerRadius  = x;
    self.clipsToBounds = YES;
}
-(void)cornerRadius_wl:(CGFloat)x borderWidth:(CGFloat)w borderColor:(UIColor *)color{
//    self.layer.shouldRasterize = YES;

    self.layer.borderWidth = w;
    self.layer.borderColor = [color CGColor];
    self.layer.cornerRadius  = x;
    self.clipsToBounds = YES;
}

-(void)cornerRadiusBorderBorderColorDefault_wl{
//    self.layer.shouldRasterize = YES;

    self.layer.borderWidth = .5f;
    self.layer.borderColor = [[UIColor grayColor] CGColor];
    self.clipsToBounds = YES;
}


@end
