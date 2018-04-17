//
//  WLNewPagingModeModel.h
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WLNewPagingModeView,WLNewPagingModeModelProperties;

@interface WLNewPagingModeModel : NSObject
/**
 储存可滑动试图的 属性
 */
@property (nonatomic, strong) NSMutableArray<WLNewPagingModeView *> *views;
/**
 储存一些默认设置
 */
@property (nonatomic, strong) WLNewPagingModeModelProperties *properties;


/**
 默认选中的标签位置
 */
@property (nonatomic, assign) NSInteger seleteNum;

/**
 是否均分标签栏
 */
@property (nonatomic, assign) BOOL isSharingTitle;
/**
 是否在合适的时间显示更多按钮
 */
@property (nonatomic, assign) BOOL isShowMoreButton;



/**
 测试
 */
@property(nonatomic,assign) BOOL isTest;
@end





@interface WLNewPagingModeView : NSObject
/**
 标签栏对应的标题
 */
@property(nonatomic,strong) NSString *title;
/**
 字体
 */
@property(nonatomic,assign) CGFloat fontSize;
/**
 为选中颜色
 */
@property(nonatomic,strong) UIColor *fontColor;
/**
 选中颜色
 */
@property(nonatomic,strong) UIColor *fontSeleteColor;
/**
 下划线颜色
 */
@property(nonatomic,strong) UIColor *lineColor;
/**
 每个试图数据
 */
@property(nonatomic,strong) id data;
/**
 各个视图标记
 */
@property(nonatomic,strong) NSString *type;
/**
 当前页需要加载哪一个试图
 */
@property(nonatomic,strong) NSString *viewClassName;
/**
 独立标示。 用于复用。要绝对唯一
 */
@property(nonatomic,strong) NSString *unique;
/**
 是否选中
 */
@property(nonatomic,assign) BOOL isSelete;


@end







@interface WLNewPagingModeModelProperties : NSObject
/**
 标签栏高度
 */
@property(nonatomic,assign) CGFloat topHight;
/**
 下划线颜色
 */
@property(nonatomic,strong) UIColor *lineColor;
/**
 分界线颜色
 */
@property(nonatomic,strong) UIColor *buttonLineColor;
/**
 分界线位置 同时也影响item位置
 */
@property(nonatomic,assign) UIEdgeInsets lineViewEdge;


/**
 是否选择第一个    NO：不归零    YES：归零
 */
@property(nonatomic,assign) BOOL isZero;
@end
