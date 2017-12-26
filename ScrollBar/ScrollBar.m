//
//  ScrollBar.m
//  ScrollBar
//
//  Created by qq on 2017/3/22.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ScrollBar.h"
#import "UIScrollView+UITouch.h"

@interface ScrollBar()

@end

@implementation ScrollBar

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}
-(instancetype)init{
    CGRect rect = CGRectMake(0, 0, 220, 220);
    self = [self initWithFrame:rect];
    return self;
}

-(void)setup{
    self.fontSize = 15;
    self.titleMaxWidth = 120;
    self.titleMaxHeight = 22;
    self.titles = [@[@"中国成语故事历史文化传播",@"少儿科普知识",@"中国成语故事历史文化传播",@"少儿科普知识",@"中国成语故事历史文化传播"] mutableCopy];
    
    self.titleColor = [UIColor darkTextColor];
    self.titleSelColor = [UIColor redColor];
    self.gapOfTitles=8;
    
    // 不要在初始化方法里添加 subLayers,而应当在 layoutSubviews 方法中添加
    // [self layoutTitles];
    
    self.advancedMode = NO;
    self.selFontSize = self.fontSize;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    // layoutSubivews 会在 storyboard 加载成功后调用，这里是重绘 subLayers 的好地方
    [self layoutTitles];
}
// MARK: - Private
-(void)layoutTitles{
//    NSLog(@"%s",__func__);
    textLayers = [NSMutableArray new];
    
    [self initScrollView];
    
    for(int i = 0 ;i<_titles.count;i++){
    
        CATextLayer* textLayer=[CATextLayer layer];

        [textLayers addObject:textLayer];
        
        [self configTitle:i];
        
        [self.scrollView.layer addSublayer:textLayer];
        
    }
    [self resizeScrollView];
    [self scrollToTitle:_selIndex];
    
}
-(void)scrollToTitle:(NSInteger)index{
    if(index>=0 && index<textLayers.count){
        CATextLayer *titleLayer = textLayers[index];
        
//        CGFloat titleRight=CGRectGetMaxX(titleLayer.frame);
//        CGFloat titleLeft=CGRectGetMinX(titleLayer.frame);
//        
//        CGFloat scrollVisibleLeft = self.scrollView.contentOffset.x;
//        CGFloat scrollVisibleRight = scrollVisibleLeft + CGRectGetWidth(self.scrollView.frame);
        
//        BOOL titleLayerInvisible = titleRight > scrollVisibleRight || titleLeft < scrollVisibleLeft;// 这个 title 是否处于不可见区域
        
        
//        if(titleLayerInvisible){
            CGRect rect=titleLayer.frame;// 在文字左右加一点空白，好看
            // 在目标 title 左右各片移一个 title，好看
            if(index>0 && index < textLayers.count-1){
                CATextLayer* preTitle = textLayers[index-1];
                CATextLayer* nextTitle = textLayers[index+1];
                
                rect = CGRectMake(CGRectGetMinX(preTitle.frame), CGRectGetMinY(rect), CGRectGetMaxX(nextTitle.frame)-CGRectGetMinX(preTitle.frame), CGRectGetHeight(rect));
            }
            
        rect = CGRectInset(rect, -20, 0);
            [self.scrollView scrollRectToVisible:rect animated:YES];
        }
//    }
}
-(CGSize)titleTextSize:(NSInteger)index{
    
    NSString* title = _titles[index];
    CGFloat fontSize = index==_selIndex?_selFontSize:_fontSize;
    UIFont *font= index==_selIndex?[UIFont boldSystemFontOfSize:fontSize]:[UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: textStyle};
    
    CGSize titleSize = [title boundingRectWithSize: CGSizeMake(self.titleMaxWidth, self.frame.size.height)  options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size;
    
    return titleSize;
}
-(CGFloat)leftOffset:(NSInteger)index{
    CGFloat offset = 0;
    if(index>=0 && index < _titles.count){

        for(int i=0;i<index;i++){
            offset+=[self titleTextSize:i].width+_gapOfTitles;
        }
        offset+=(index+1)*_gapOfTitles;
    }
    return offset;
}
-(void)configTitle:(NSInteger)index{
    NSString* title = _titles[index];
    CATextLayer* textLayer = textLayers[index];
    
    CGFloat fontSize = index==_selIndex?_selFontSize:_fontSize;
    textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont italicSystemFontOfSize:fontSize]);
    textLayer.fontSize = fontSize;
    
    CGSize size= [self titleTextSize:index];
    
    textLayer.frame = CGRectMake([self leftOffset:index], (self.frame.size.height-fontSize)/2, size.width, size.height);
    textLayer.string = title;
    
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    textLayer.foregroundColor = (self.selIndex == index)?self.titleSelColor.CGColor:self.titleColor.CGColor;
    
    textLayer.contentsScale = [UIScreen mainScreen].scale;
}
- (void)initScrollView {
    [_scrollView removeFromSuperview];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //        scrollView.contentSize = CGSizeMake(MAX(self.frame.size.width, titlesWidth), self.frame.size.height);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator  = NO;
    _scrollView.bounces = YES;
    
    [self addSubview:_scrollView];
}
-(void)resizeScrollView{
    CATextLayer* textLayer = textLayers.lastObject;
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(textLayer.frame)+_gapOfTitles, self.frame.size.height);
}
// MARK: - Getters
-(CGFloat)titlesWidth{
    if(textLayers==nil)return 0;
    CATextLayer *lastTextLayer = textLayers.lastObject;
    return CGRectGetMaxX(lastTextLayer.frame)+_gapOfTitles;
}

// MARK: - Setters
-(void)setTitles:(NSArray*)titles{
    _titles = [titles mutableCopy];
    [self setNeedsLayout];
}
-(void)setFontSize:(CGFloat)fontSize{
    _fontSize=fontSize;
    [self setNeedsLayout];
}
-(void)setSelFontSize:(CGFloat)fontSize{
    _selFontSize=fontSize;
    [self setNeedsLayout];
}
-(void)setTitleColor:(UIColor*)titleColor{
    _titleColor =titleColor;
    [self setNeedsLayout];
}
-(void)setTitleSelColor:(UIColor*)color{
    _titleSelColor = color;
    [self setNeedsLayout];
}
-(void)setTitleMaxWidth:(CGFloat)width{
    _titleMaxWidth = width;
    [self setNeedsLayout];
}
-(void)setTitleMaxHeight:(CGFloat)height{
    _titleMaxHeight = height;
    [self setNeedsLayout];
}
-(void)gapOfTitles:(CGFloat)gap{
    _gapOfTitles = gap;
    [self setNeedsLayout];
}
-(void)setTitleTop:(CGFloat)top{
    _titleTop = top;
    [self setNeedsLayout];
}
-(void)setSelIndex:(NSInteger)index{
    if(index>=0 && index<textLayers.count && index!=_selIndex){
        _selIndex = index;
//        for(int i = 0;i<textLayers.count;i++){
//            CATextLayer *layer=textLayers[i];
//            layer.foregroundColor = _selIndex==i?self.titleSelColor.CGColor:
//            self.titleColor.CGColor;
//            layer.fontSize = _selIndex==i?_selFontSize:_fontSize;
//        }
        [self setNeedsLayout];
        [self scrollToTitle:index];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];

    CALayer *layer = [self.scrollView.layer hitTest:point];

    
    if([layer isKindOfClass:[CATextLayer class]]){
        
        NSInteger index=[textLayers indexOfObject:layer];
        if(index != NSNotFound && index != self.selIndex){

            if(self.delegate && [self.delegate respondsToSelector:@selector(scrollBar:switchTo:)]){
                [self.delegate scrollBar:self switchTo:index];
            }
        }
        
    }
    
}
-(void)releaseResource{
    for(__strong CALayer * layer in textLayers){
        [layer removeFromSuperlayer];
        layer =  nil;
    }
    if(self.delegate){
        for(__strong UIViewController* vc in self.delegate.childViewControllers){
            [vc willMoveToParentViewController:nil];
            [vc removeFromParentViewController];
            vc = nil;
        }
    }
}
@end
