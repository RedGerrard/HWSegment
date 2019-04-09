//
//  HWViewController.m
//  HWSegment
//
//  Created by wozaizhelishua on 04/08/2019.
//  Copyright (c) 2019 wozaizhelishua. All rights reserved.
//

#import "HWViewController.h"
#import "HWSegmentBar.h"
#import "UIView+HWFrame.h"
#import "HWSegmentVC.h"

@interface HWViewController ()

@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSInteger defaultIndex = 0;
    
    HWSegmentBar *segmentBar = [[HWSegmentBar alloc]initWithFrame:CGRectMake(0, 60, self.view.width, 35)];
    
    NSArray *titles = @[@"专辑", @"声音", @"下载中",@"专辑", @"声音"];
 
    [segmentBar setUpWithTitles:titles titleNormalColor:[UIColor lightGrayColor] titleSelectedColor:[UIColor redColor] titleFontSize:14 titleSelectedFontSize:(CGFloat)16 isTitleSelectedBold:NO lineColor:[UIColor redColor] defaultIndex:defaultIndex];
    
    [self.view addSubview:segmentBar];
    
    
    
    HWSegmentVC *segmentVC = [HWSegmentVC new];
    [self addChildViewController:segmentVC];
    segmentVC.view.frame = CGRectMake(0, CGRectGetMaxY(segmentBar.frame), self.view.width, self.view.height - segmentBar.height);
    [self.view addSubview:segmentVC.view];
    
    
    
    segmentBar.click = ^(NSInteger fromIndex, NSInteger toIndex) {
        [segmentVC showChildVCViewsAtIndex:toIndex];
    };
    segmentVC.scrollBlock = ^(NSInteger index) {
        segmentBar.selectIndex = index;
    };
    
    
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc5 = [UIViewController new];
    vc5.view.backgroundColor = [UIColor yellowColor];
    [segmentVC setUpWithChildVCs:@[vc1, vc2, vc3, vc4, vc5] defaultIndex:defaultIndex];
}

@end
