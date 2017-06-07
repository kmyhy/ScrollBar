//
//  UIViewController+Swipe.h
//  ScrollBar
//
//  Created by qq on 2017/6/7.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Swipe)
@property (nonatomic, strong,readonly) UISwipeGestureRecognizer* leftSwipe;
@property (nonatomic, strong,readonly) UISwipeGestureRecognizer* rightSwipe;

@property (nonatomic, assign) BOOL leftSwipeTargetAdded;
@property (nonatomic, assign) BOOL rightSwipeTargetAdded;

@end
