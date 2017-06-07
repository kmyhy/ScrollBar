//
//  UIViewController+Swipe.m
//  ScrollBar
//
//  Created by qq on 2017/6/7.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "UIViewController+Swipe.h"
#import <objc/runtime.h>

@implementation UIViewController (Swipe)

@dynamic leftSwipe;
@dynamic rightSwipe;
@dynamic leftSwipeTargetAdded;
@dynamic rightSwipeTargetAdded;


// MARK: - Getter/Setter
-(void)setLeftSwipeTargetAdded:(BOOL)leftSwipeTargetAdded{
     objc_setAssociatedObject(self, @selector(leftSwipeTargetAdded), @(leftSwipeTargetAdded), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)leftSwipeTargetAdded{
    NSNumber* number = objc_getAssociatedObject(self, @selector(leftSwipeTargetAdded));
    if(number!=nil){
        return number.boolValue;
    }
    return NO;
}
-(void)setRightSwipeTargetAdded:(BOOL)rightSwipeTargetAdded{
    objc_setAssociatedObject(self, @selector(rightSwipeTargetAdded), @(rightSwipeTargetAdded), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)rightSwipeTargetAdded{
    NSNumber* number = objc_getAssociatedObject(self, @selector(rightSwipeTargetAdded));
    if(number!=nil){
        return number.boolValue;
    }
    return NO;
}

- (void)setLeftSwipe:(UISwipeGestureRecognizer *)leftSwipe{
    objc_setAssociatedObject(self, @selector(leftSwipe), leftSwipe, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UISwipeGestureRecognizer*)leftSwipe {
    UISwipeGestureRecognizer* leftSwipe = objc_getAssociatedObject(self, @selector(leftSwipe));
    if(leftSwipe == nil){
        leftSwipe = [[UISwipeGestureRecognizer alloc] init];
        leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        self.leftSwipe = leftSwipe;
        [self.view addGestureRecognizer:leftSwipe];
    }
    return leftSwipe;
}

-(void)setRightSwipe:(UISwipeGestureRecognizer *)rightSwipe{
    objc_setAssociatedObject(self, @selector(rightSwipe), rightSwipe, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UISwipeGestureRecognizer*)rightSwipe{
    UISwipeGestureRecognizer* rightSwipe = objc_getAssociatedObject(self, @selector(rightSwipe));
    if(rightSwipe == nil){
        rightSwipe = [[UISwipeGestureRecognizer alloc] init];
        rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        self.rightSwipe = rightSwipe;
        [self.view addGestureRecognizer:rightSwipe];
    }
    return rightSwipe;

}
@end
