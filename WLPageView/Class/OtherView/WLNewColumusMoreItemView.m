//
//  WLNewColumusMoreItemView.m
//  SeaWorld
//
//  Created by 王亮 on 2017/12/12.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "WLNewColumusMoreItemView.h"
#import "WLNewColumnsButton.h"
#import <objc/runtime.h>
#import "WL_Macros.h"

@interface WLNewColumusMoreItemView (){
    WLNewPagingModeModel *_itemModel;

    WLNewPagingModeView *_seleteItemModel;
}

@end
@implementation WLNewColumusMoreItemView

+(instancetype)showConstraintView:(UIView *)constraintView
                          addView:(UIView *)addView
                        itemModel:(WLNewPagingModeModel *)itemModel
                  seleteItemModel:(WLNewPagingModeView *)seleteItemModel
                  clickItemButton:(clickItemButton)clickItemButton
                   clossViewBlock:(clossViewBlock)clossViewBlock{

    
    WLNewColumusMoreItemView *showView = [[self alloc]init];
    showView.userInteractionEnabled = YES;
    showView.alpha = 0;

    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, addView.frame.size.width, addView.frame.size.height)];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.userInteractionEnabled = YES;
    bgView.alpha = 0;
    objc_setAssociatedObject(showView,"bgView",bgView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [bgView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [showView clossView];
    }];
    
    
    UIView *bgBlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, addView.frame.size.width, addView.frame.size.height)];
    bgBlackView.backgroundColor = RGBA(0,0,0,0.6f);
    bgBlackView.userInteractionEnabled = YES;
    bgBlackView.alpha = 0;
    objc_setAssociatedObject(showView,"bgBlackView",bgBlackView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    [addView addSubview:bgBlackView];
    [addView addSubview:bgView];
    [addView addSubview:showView];
    
    
    
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(constraintView);
        make.top.mas_equalTo(constraintView.mas_bottom);
        make.height.mas_offset(0);
    }];
    
    [bgBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(constraintView);
        make.top.mas_equalTo(showView.mas_bottom);
        make.height.mas_offset(Main_Screen_Height_WL);
    }];
    
    //立即更新约束
    [showView layoutIfNeeded];
    
//    添加数据 刷新高度
    [showView setViewItemModel:itemModel seleteItemModel:seleteItemModel changeViewSize:^(WLNewColumusMoreItemView *view, CGFloat viewHeight) {
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(viewHeight);
        }];
    } clickItemButton:clickItemButton clossViewBlock:clossViewBlock];
    
    
    [UIView animateWithDuration:0.5f animations:^{
        bgBlackView.alpha = 1;
        bgView.alpha = 1;
        showView.alpha = 1;
    }];
    
    return showView;
}
-(void)clossView{
    UIView *bgView = objc_getAssociatedObject(self, "bgView");
    UIView *bgBlackView = objc_getAssociatedObject(self, "bgBlackView");
    
    objc_removeAssociatedObjects(self);
    [bgBlackView removeFromSuperview];
    [bgView removeFromSuperview];
    [self removeFromSuperview];
    
    if (self.clossViewBlock) {
        self.clossViewBlock(self);
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setViewItemModel:(WLNewPagingModeModel *)itemModel
        seleteItemModel:(WLNewPagingModeView *)seleteItemModel
         changeViewSize:(changeViewSize)changeViewSize
        clickItemButton:(clickItemButton)clickItemButton
         clossViewBlock:(clossViewBlock)clossViewBlock{
    _itemModel = itemModel;
    _seleteItemModel = seleteItemModel;
    self.changeViewSize = changeViewSize;
    self.clickItemButton = clickItemButton;
    self.clossViewBlock = clossViewBlock;
    [self addTag:_itemModel.views];
}


/**
 给商品添加标签
 */
-(void)addTag:(NSMutableArray<WLNewPagingModeView *> *)sender{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    //    上一个item
    static UIButton *recordBtn =nil;
    
    //    获取视图宽度
    CGFloat selfWidth = self.frame.size.width;
    
    //    设置item 水平间距
    CGFloat itemHorizontal = 10;
    //    设置item 垂直间距
    CGFloat itemVertical = 10;
    //    设置整体上间距
    CGFloat itemTop = 10;
    //    设置整体左间距
    CGFloat itemLeft = 10;
    //    设置整体下间距
    CGFloat itemBottom = 10;
    //    设置整体右间距
    CGFloat itemRight = 10;
    
    
    //    设置item高度
    CGFloat itemHeight = 38;
    //    设置item宽度
    CGFloat itemWidth = (selfWidth - itemLeft - itemRight - (itemHorizontal * 2))/3;
    
    
    //    创建一个新数组 防止修改源数据
    NSMutableArray *itemArr = [NSMutableArray arrayWithArray:sender];
    //    添加一个收回按钮
    WLNewPagingModeView *clossModel = [WLNewPagingModeView new];
    clossModel.title = @"收起";
    [itemArr addObject:clossModel];
    
    [itemArr enumerateObjectsUsingBlock:^(WLNewPagingModeView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = obj.title;
        
        UIButton *btn = [[UIButton alloc]init];
        
        
        if ([_seleteItemModel.title isEqualToString:obj.title]) {
            btn.backgroundColor = HexColor(0xEAF8FF);
            [btn cornerRadius_wl:4];
            [btn setTitleColor:HexColor(0x01A1FE) forState:UIControlStateNormal];
        }
        else if ([name isEqualToString:@"收起"]) {
            WLNewColumnsButton *clossBtn = [[WLNewColumnsButton alloc]init];
            clossBtn.backgroundColor = [UIColor whiteColor];
            [clossBtn cornerRadius_wl:4 borderWidth:0.5f borderColor:HexColor(0x01A1FE)];
            [clossBtn setTitleColor:HexColor(0x01A1FE) forState:UIControlStateNormal];
            [clossBtn setImage:[[UIImage imageNamed:@"public_top"] imageWithColor:HexColor(0x01A1FE)] forState:UIControlStateNormal];
            btn = clossBtn;
        }
        else{
            btn.backgroundColor = HexColor(0xF2F2F2);
            [btn cornerRadius_wl:4];
            [btn setTitleColor:HexColor(0x999999) forState:UIControlStateNormal];
        }

        btn.clipsToBounds = YES;
        btn.tag = idx;
        [btn setTitle:[NSString stringWithFormat:@"%@",name] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
////        直接更新btn大小
//        [btn sizeToFit];
////        获取btn大小
//        CGRect rect = btn.frame;
//        设置btn大小
//        CGFloat BtnW = rect.size.width + 15;
        
        CGFloat BtnW = itemWidth;
        CGFloat BtnH = itemHeight;
//        获取btn大小
        CGRect rect = CGRectMake(0, 0, BtnW, BtnH);
        btn.frame = rect;
        
        if (idx == 0){
//            设置第一个item位置
            btn.frame =CGRectMake(itemLeft, itemTop, BtnW, BtnH);
        }
        else{
//            计算该行剩余空间    父视图宽度 -          上一个按钮水平最大值     -  一个空间水平间距  -   右间距
            CGFloat yuWidth = selfWidth - CGRectGetMaxX(recordBtn.frame) - itemHorizontal - itemRight;
//            判断剩余空间是否大于现在要添加的按钮  设置兼容差值 在1以内的同行添加策略
            NSLog(@"%f",(yuWidth - rect.size.width));
            if ((yuWidth - rect.size.width) >= -1.f) {
                btn.frame =CGRectMake( CGRectGetMaxX(recordBtn.frame) + itemHorizontal, recordBtn.frame.origin.y, BtnW, BtnH);
            }else{
                btn.frame =CGRectMake( itemLeft, CGRectGetMaxY(recordBtn.frame) + itemVertical, BtnW, BtnH);
            }
            
        }
        
        [btn addTarget:self action:@selector(click_item_button:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        recordBtn = btn;
    }];
    
    CGFloat allItemHeight = CGRectGetMaxY(recordBtn.frame) + itemBottom;
    
    if (self.changeViewSize) {
        self.changeViewSize(self, allItemHeight);
    }
    NSLog(@"控件整体高度%f",allItemHeight);
}
-(void)click_item_button:(UIButton *)sender{
//    操作前先关闭页面 防止约束问题
    [self clossView];
    if ([sender.titleLabel.text isEqualToString:@"收起"]) {return;}
    if (self.clickItemButton) {
        self.clickItemButton(self, _itemModel.views[sender.tag],sender.tag);
    }
}
@end
