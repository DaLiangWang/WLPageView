//
//  WLNewColumnsViewCollectionViewCell.m
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "WLNewColumnsViewCollectionViewCell.h"
#import "WL_Macros.h"
@interface WLNewColumnsViewCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property(nonatomic,strong) UIView *lineView;


@end
@implementation WLNewColumnsViewCollectionViewCell
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor redColor];
        _lineView.hidden = YES;
    }
    return _lineView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.height.mas_offset(2);
        make.width.mas_equalTo(self).mas_offset(-10);
        make.centerX.mas_equalTo(self);
    }];
    
    // Initialization code
}

-(void)setTopic:(WLNewPagingModeView *)topic{
    _topic = topic;
    self.title.text = _topic.title;
    self.title.font = [UIFont systemFontOfSize:_topic.fontSize];
    
    self.lineView.backgroundColor = _topic.lineColor;
    
    
    self.lineView.hidden = !_topic.isSelete;
    self.title.textColor = _topic.isSelete?_topic.fontSeleteColor:_topic.fontColor;
}
@end
