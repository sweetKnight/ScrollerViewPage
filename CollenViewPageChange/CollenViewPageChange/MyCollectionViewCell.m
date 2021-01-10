//
//  MyCollectionViewCell.m
//  CollenViewPageChange
//
//  Created by 冯剑锋 on 2017/7/31.
//  Copyright © 2017年 冯剑锋. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()
@property (nonatomic, strong) UIView * colorView;
@end

@implementation MyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        _colorView = [[UIView alloc]init];
//        self.contentView.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:_colorView];
    }
    return self;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    _colorView.frame = CGRectMake(0, 0, self.bounds.size.width - 40, self.bounds.size.height);
//}

-(void)setContensColor:(UIColor *)contensColor{
    _contensColor = contensColor;
//    _colorView.backgroundColor = _contensColor;
    self.contentView.backgroundColor = _contensColor;
}

@end
