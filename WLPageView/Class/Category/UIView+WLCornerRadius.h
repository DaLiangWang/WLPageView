//
//  UIView+WLCornerRadius.h
//  CeXi
//
//  Created by Rice on 2017/5/23.
//  Copyright © 2017年 wangLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLCornerRadius)
-(void)cornerRadius_wl;
-(void)cornerRadius_wl:(CGFloat)x;
-(void)cornerRadius_wl:(CGFloat)x borderWidth:(CGFloat)w borderColor:(UIColor *)color;


-(void)cornerRadiusBorderBorderColorDefault_wl;
@end
