//
//  HWSegmentBar.m
//  HWSegment_Example
//
//  Created by 袁海文 on 2019/4/8.
//  Copyright © 2019年 wozaizhelishua. All rights reserved.
//

#import "HWSegmentBar.h"
#import "UIView+HWFrame.h"


@interface HWSegmentBar()

/** 内容承载视图 */
@property (nonatomic, weak) UIScrollView *contentView;

/** 添加的按钮数据 */
@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;

/** 指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@end

@implementation HWSegmentBar{
    // 最小间距
    int _kMinMargin;
    // 记录最后一次点击的按钮
    UIButton *_lastBtn;
    // 是否需要加粗
    BOOL _isTitleSelectedBold;
    // 按钮字体大小
    CGFloat _titleFontSize;
    // 按钮被选中字体大小
    CGFloat _titleSelectedFontSize;
    // 默认第几项
    NSInteger _defaultIndex;
     
}

#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)itemBtns {
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}
- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat indicatorH = 2;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - indicatorH, 0, indicatorH)];
        
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}
#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _kMinMargin = 20;
    }
    return self;
}


#pragma mark - 接口

-(void)setUpWithTitles:(NSArray<NSString *>*)titles titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor titleFontSize:(CGFloat)titleFontSize titleSelectedFontSize:(CGFloat)titleSelectedFontSize isTitleSelectedBold:(BOOL)isTitleSelectedBold lineColor:(UIColor *)lineColor defaultIndex:(NSInteger) defaultIndex{
    
    _titleFontSize = titleFontSize;
    _titleSelectedFontSize = titleSelectedFontSize;
    _isTitleSelectedBold = isTitleSelectedBold;
    _defaultIndex = defaultIndex;
    
    // 删除之前添加的子控件
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    
    // 根据所有的选项数据源， 创建Button, 添加到内容视图
    for (NSString *title in titles) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:titleSelectedColor forState:UIControlStateSelected];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:_titleFontSize];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    self.indicatorView.backgroundColor = lineColor;
    
    self.selectIndex = defaultIndex;
    
    // 手动刷新布局
    [self setNeedsLayout]; // 标示, 刷新标识
    [self layoutIfNeeded]; // 立即刷新, 检测有没有刷新标识, 有的话, 才会立即刷新
    
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    // 数据过滤
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self btnClick:btn];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    // 计算margin
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    
    
    CGFloat caculateMargin = (self.width - totalBtnWidth) / (self.itemBtns.count + 1);
    if (caculateMargin < _kMinMargin) {
        //当选项太多时caculateMargin甚至是负数，此时手动设置一个最小间距kMinMargin
        caculateMargin = _kMinMargin;
    }
    
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        // w, h
        [btn sizeToFit];
        // y 0
        // x, y,
        btn.x = lastX;
        btn.y = 0;
        lastX += btn.width + caculateMargin;
        
    }
 
    self.contentView.contentSize = CGSizeMake(lastX, 0);
 
    if (self.itemBtns.count == 0) {
        return;
    }
    
    
    UIButton *btn = self.itemBtns[_selectIndex];
    self.indicatorView.width = btn.width;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.y = self.height - self.indicatorView.height;
}
#pragma mark - 私有方法
- (void)btnClick: (UIButton *)btn {
    
    if (self.click) {
        self.click(_lastBtn.tag,btn.tag);
    } 
    
    _selectIndex = btn.tag;

    _lastBtn.selected = NO;
    
    if (_titleFontSize != _titleSelectedFontSize) {
        _lastBtn.titleLabel.font = [UIFont systemFontOfSize:_titleFontSize];
        [_lastBtn sizeToFit];
    }
    
    
    btn.selected = YES;
    if (_isTitleSelectedBold) {
        
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:_titleSelectedFontSize];
    }else{
        btn.titleLabel.font = [UIFont systemFontOfSize:_titleSelectedFontSize];
    }
    [btn sizeToFit];

    
    _lastBtn = btn;

    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = btn.width;
        self.indicatorView.centerX = btn.centerX;
    }];
 

    CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;

    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }

    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
    
}
@end
