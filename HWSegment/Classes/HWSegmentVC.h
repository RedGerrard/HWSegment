//
//  HWSegmentVC.h
//  HWSegment_Example
//
//  Created by 袁海文 on 2019/4/8.
//  Copyright © 2019年 wozaizhelishua. All rights reserved.
//

//说明：本控制器是一个容器控制器

#import <UIKit/UIKit.h>

typedef void(^ScrollBlock)(NSInteger index);

@interface HWSegmentVC : UIViewController

/**
 容器控制器的滑动事件，index表示滑到第几个控制器了
 */
@property (nonatomic, copy) ScrollBlock scrollBlock;

/**
 设置子控制器

 @param childVCs 子控制器数组
 @param defaultIndex 初始显示第几个子控制器
 */
- (void)setUpWithChildVCs: (NSArray <UIViewController *>*)childVCs defaultIndex:(NSInteger) defaultIndex;

/**
 显示第几个控制器

 @param index 要显示的控制器的index
 */
- (void)showChildVCViewsAtIndex: (NSInteger)index;
@end
