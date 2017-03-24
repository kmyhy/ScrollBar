//
//  ScrollSwitchViewsBar.h
//  ScrollBar
//
//  Created by qq on 2017/3/24.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ScrollBar.h"

@class SwitchViewScrollBar;
@protocol SwitchViewScrollBarDelegate <ScrollBarDelegate>
@required
-(UIView*)containerViewInScrollBar:(SwitchViewScrollBar*)scrollBar;
-(UIViewController*)scrollBar:(SwitchViewScrollBar*)scrollBar controllerAtIndex:(NSInteger)index;
@end

IB_DESIGNABLE
@interface SwitchViewScrollBar : ScrollBar
@property(weak,nonatomic)UIViewController<SwitchViewScrollBarDelegate> *delegate;
-(void)switchTo:(NSInteger)to;
@end
