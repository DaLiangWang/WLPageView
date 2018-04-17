//
//  UIView+Extension.m
//  BBBS
//
//  Created by 👄 on 15/7/31.
//  Copyright (c) 2015年 sczy. All rights reserved.
//
#import "UIView+WExtension.h"

@implementation UIView (Extension)
-(void)setWl_origin:(CGPoint)wl_origin {
    CGRect frame = self.frame;
    frame.origin = wl_origin;
    self.frame = frame;
}

- (CGPoint)wl_origin
{
    return self.frame.origin;
}

- (void)setWl_size:(CGSize)wl_size
{
    CGRect frame = self.frame;
    frame.size = wl_size;
    self.frame = frame;
}

- (CGSize)wl_size
{
    return self.frame.size;
}
- (void)setWl_x:(CGFloat)wl_x
{
    CGRect frame = self.frame;
    frame.origin.x = wl_x;
    self.frame = frame;
}

- (CGFloat)wl_x
{
    return self.frame.origin.x;
}

- (void)setWl_centerX:(CGFloat)wl_centerX
{
    CGPoint center = self.center;
    center.x = wl_centerX;
    self.center = center;
}

- (CGFloat)wl_centerX
{
    return self.center.x;
}

- (void)setWl_centerY:(CGFloat)wl_centerY
{
    CGPoint center = self.center;
    center.y = wl_centerY;
    self.center = center;
}

- (CGFloat)wl_centerY
{
    return self.center.y;
}


- (void)setWl_y:(CGFloat)wl_y
{
    CGRect frame = self.frame;
    frame.origin.y = wl_y;
    self.frame = frame;
}

- (CGFloat)wl_y
{
    return self.frame.origin.y;
}

- (void)setWl_width:(CGFloat)wl_width
{
    CGRect frame = self.frame;
    frame.size.width = wl_width;
    self.frame = frame;
}

- (CGFloat)wl_width
{
    return self.frame.size.width;
}

- (void)setWl_height:(CGFloat)wl_height
{
    CGRect frame = self.frame;
    frame.size.height = wl_height;
    self.frame = frame;
}

- (CGFloat)wl_height
{
    return self.frame.size.height;
}

-(CGFloat)wl_maxX
{
    return self.frame.origin.x + self.frame.size.width;

}

-(void)setWl_maxX:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)wl_maxY
{
    return self.frame.origin.y + self.frame.size.height;

}


-(void)setWl_maxY:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



/*
 * 当前这个View是否和keyWindow有重叠
 */
- (BOOL)wl_isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
/*
 * 当前这个View是否 全部显示在 keyWindow上
 */
- (BOOL)wl_isShowingAllOnKeyWindowBol
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    CGRect intersectionRect = CGRectIntersection(newFrame, winBounds);
    
    BOOL w = intersectionRect.size.width >= newFrame.size.width;
    
    BOOL h = intersectionRect.size.height >= newFrame.size.height;
    
    return w && h;
}
/*
 * 当前这个View是否 全部显示在 keyWindow上 如果是 则返回 CGRectZero 否则返回大小
 */
- (CGRect)wl_isShowingAllOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    CGRect intersectionRect = CGRectIntersection(newFrame, winBounds);
    
    BOOL w = intersectionRect.size.width >= newFrame.size.width;
    
    BOOL h = intersectionRect.size.height >= newFrame.size.height;
    
    if (w && h) {
        return CGRectZero;
    }
    else{
        return CGRectMake(0, 0, intersectionRect.size.width - newFrame.size.width, intersectionRect.size.height - newFrame.size.height);
    }
    
}
// 从xib加载
+ (instancetype)wl_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}



@end
