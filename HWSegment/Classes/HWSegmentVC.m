//
//  HWSegmentVC.m
//  HWSegment_Example
//
//  Created by 袁海文 on 2019/4/8.
//  Copyright © 2019年 wozaizhelishua. All rights reserved.
//

#import "HWSegmentVC.h"
#import "UIView+HWFrame.h"

@interface HWSegmentVC ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation HWSegmentVC

#pragma mark - 懒加载
- (UIScrollView *)contentView {
    if (!_contentView) {
        
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setUpWithChildVCs: (NSArray <UIViewController *>*)childVCs defaultIndex:(NSInteger) defaultIndex{
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    
    self.contentView.contentSize = CGSizeMake(childVCs.count * self.view.width, 0);
    
    [self showChildVCViewsAtIndex:defaultIndex];
}

- (void)showChildVCViewsAtIndex: (NSInteger)index {
    
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    // 这里不会重复添加，每次添加的控制器都来自self.childViewControllers数组，他们的地址都一样
    [self.contentView addSubview:vc.view];
    
    // 滚动到对应的位置
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:NO];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    self.contentView.frame = self.view.bounds;
    
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算最后的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    if (self.scrollBlock) {
        self.scrollBlock(index);
    }
    
}

@end
