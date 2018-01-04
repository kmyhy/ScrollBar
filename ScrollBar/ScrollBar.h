//
//  ScrollBar.h
//  ScrollBar
//
//  Created by qq on 2017/3/22.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollBar;
@protocol ScrollBarDelegate <NSObject>

@optional
-(void)scrollBar:(ScrollBar*)scrollBar switchTo:(NSInteger)to;

@end

IB_DESIGNABLE
@interface ScrollBar : UIControl{
    NSMutableArray* textLayers;
}
@property(strong,nonatomic)IBInspectable NSArray* titles;
@property(assign,nonatomic)IBInspectable CGFloat fontSize;
@property(strong,nonatomic)IBInspectable UIColor* titleColor;
@property(strong,nonatomic)IBInspectable UIColor* titleSelColor;
@property(assign,nonatomic)IBInspectable CGFloat titleMaxWidth;
@property(assign,nonatomic)IBInspectable CGFloat titleMaxHeight;
@property(assign,nonatomic)IBInspectable CGFloat gapOfTitles;
@property(assign,nonatomic)IBInspectable CGFloat titleTop;
@property(assign,nonatomic)IBInspectable NSInteger selIndex;
// 大小字模式特殊样式专用属性
@property(assign,nonatomic)IBInspectable BOOL advancedMode;// 是否使用大小字模式
@property(assign,nonatomic)IBInspectable CGFloat selFontSize;// 高级模式下，选中的字体大小

@property(weak,nonatomic)UIViewController<ScrollBarDelegate> *delegate;

@property(strong,nonatomic)UIScrollView *scrollView;
@property(assign,nonatomic)CGFloat titlesWidth;
-(void)releaseResource;
@end

