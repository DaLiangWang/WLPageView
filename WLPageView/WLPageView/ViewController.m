//
//  ViewController.m
//  WLPageViewController
//
//  Created by 王亮 on 2018/4/16.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "ViewController.h"
#import "WLNewPagingModeMainView.h"
#import "WL_Macros.h"
#import "WLNewPagingModeModel.h"

@interface ViewController ()
@property(nonatomic,strong) WLNewPagingModeMainView *pagingModeMainView;

@end

@implementation ViewController
#pragma mark - 延迟加载
-(WLNewPagingModeMainView *)pagingModeMainView{
    if (!_pagingModeMainView) {
        _pagingModeMainView = [[WLNewPagingModeMainView alloc]init];
        _pagingModeMainView.backgroundColor = [UIColor whiteColor];
    }
    return _pagingModeMainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pagingModeMainView];
    [self.pagingModeMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
    
    
    
    
    // 0全部   1待付款   2待收货   3退款/退货   9已完成   6关闭/取消
    NSMutableArray *viewArr = [NSMutableArray array];
    NSString *typeStr = @"1234";
    
    [viewArr addObject:@{@"title":@"全部订单",
                         @"viewClassName":@"WLMyOrderView",
                         @"type":typeStr,}];
    
    [viewArr addObject:@{@"title":@"待付款",
                         @"viewClassName":@"WLMyOrderView",
                         @"type":typeStr,}];
    
    [viewArr addObject:@{@"title":@"待收货",
                         @"viewClassName":@"WLMyOrderView",
                         @"type":typeStr,}];
    
    [viewArr addObject:@{@"title":@"退款/退货",
                         @"viewClassName":@"WLMyOrderView",
                         @"type":typeStr,}];
    
    [viewArr addObject:@{@"title":@"售后",
                         @"viewClassName":@"WLApplicationSaleView",
                         @"type":typeStr,}];
    
    [viewArr addObject:@{@"title":@"已完成",
                         @"viewClassName":@"WLMyOrderView",
                         @"type":typeStr,}];
    
    [viewArr addObject:@{@"title":@"关闭/取消",
                         @"viewClassName":@"WLMyOrderView",
                         @"type":typeStr,}];
    
    
    
    
    
    WLNewPagingModeModel *model = [WLNewPagingModeModel new];
    for (int i = 0; i<viewArr.count; i++) {
        NSDictionary * object = viewArr[i];
        
        WLNewPagingModeView *vi = [WLNewPagingModeView new];
        vi.title = object[@"title"];
        vi.viewClassName = object[@"viewClassName"];
        vi.type = object[@"type"];
        vi.data = object;
        vi.unique = object[@"title"];
        
        vi.fontSize = 15;
        vi.fontSeleteColor = HexColor(0x01A1FE);
        vi.fontColor = HexColor(0x999999);
        vi.lineColor = HexColor(0x01A1FE);
        
        [model.views addObject:vi];
        //        if ([self.viewLayer[@"selete"] isEqualToString:object[@"type"]]) {
        //        }
    }
    model.seleteNum = 1;
    
    model.properties.topHight = 40;
    model.properties.lineColor = HexColor(0xDDDDDD);
    model.properties.isZero = YES;
    
    model.isSharingTitle = NO;
    
    self.pagingModeMainView.model = model;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
