//
//  WLNewPagingModeModel.m
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "WLNewPagingModeModel.h"

@implementation WLNewPagingModeModel
-(WLNewPagingModeModelProperties *)properties{
    if (!_properties) {
        _properties = [[WLNewPagingModeModelProperties alloc]init];
    }
    return _properties;
}
-(NSMutableArray<WLNewPagingModeView *> *)views{
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}
@end
@implementation WLNewPagingModeView
-(UIColor *)fontSeleteColor{
    if (!_fontSeleteColor) {
        return [UIColor redColor];
    }
    return _fontSeleteColor;
}
-(UIColor *)fontColor{
    if (!_fontColor) {
        return [UIColor blackColor];
    }
    return _fontColor;
}
-(CGFloat)fontSize{
    if (!_fontSize) {
        return 14;
    }
    return _fontSize;
}
-(UIColor *)lineColor{
    if (!_lineColor) {
        return [UIColor redColor];
    }
    return _lineColor;
}

@end
@implementation WLNewPagingModeModelProperties
-(CGFloat)topHight{
    if (!_topHight) {
        return 44;
    }
    return _topHight;
}
-(UIColor *)lineColor{
    if (!_lineColor) {
        return [UIColor whiteColor];
    }
    return _lineColor;
}
-(UIColor *)buttonLineColor{
    if (!_buttonLineColor) {
        return [UIColor clearColor];
    }
    return _buttonLineColor;
}
@end
