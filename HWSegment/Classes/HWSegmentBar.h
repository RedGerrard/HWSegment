//
//  HWSegmentBar.h
//  HWSegment_Example
//
//  Created by 袁海文 on 2019/4/8.
//  Copyright © 2019年 wozaizhelishua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSInteger fromIndex, NSInteger toIndex);

@interface HWSegmentBar : UIView

/** 当前选中的索引*/
@property (nonatomic, assign) NSInteger selectIndex;

/**
 选项卡的点击事件，fromIndex是上一次，toIndex是当前点击
 */
@property (nonatomic, copy) ClickBlock click;

/**
 设置HWSegmentBar

 @param titles 标题数组
 @param titleNormalColor 标题常规颜色
 @param titleSelectedColor 标题选中颜色
 @param titleFontSize 标题字体大小
 @param isTitleSelectedBold 标题选中时字体是否需要加粗
 @param lineColor 下划线颜色
 @param defaultIndex 初始显示第几项
 */
-(void)setUpWithTitles:(NSArray<NSString *>*)titles titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor titleFontSize:(CGFloat)titleFontSize isTitleSelectedBold:(BOOL)isTitleSelectedBold lineColor:(UIColor *)lineColor defaultIndex:(NSInteger) defaultIndex;
@end
