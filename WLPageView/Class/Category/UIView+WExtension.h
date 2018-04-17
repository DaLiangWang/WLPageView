//
//  UIView+Extension.h
//  BBBS
//
//  Created by 👄 on 15/7/31.
//  Copyright (c) 2015年 sczy. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (WExtension)
@property (nonatomic, assign) CGFloat wl_x;
@property (nonatomic, assign) CGFloat wl_y;
@property (nonatomic, assign) CGFloat wl_centerX;
@property (nonatomic, assign) CGFloat wl_centerY;
@property (nonatomic, assign) CGFloat wl_width;
@property (nonatomic, assign) CGFloat wl_height;
@property (nonatomic, assign) CGSize  wl_size;
@property (nonatomic, assign) CGPoint wl_origin;
@property (nonatomic) CGFloat wl_maxX;
@property (nonatomic) CGFloat wl_maxY;
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)wl_isShowingOnKeyWindow;

/**
 * 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量
 */
+ (instancetype)wl_viewFromXib;

- (BOOL)wl_isShowingAllOnKeyWindowBol;
- (CGRect)wl_isShowingAllOnKeyWindow;

@end
