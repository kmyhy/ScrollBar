//
//  ViewController.m
//  ScrollBar
//
//  Created by qq on 2017/3/22.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ViewController.h"
#import "SwitchViewScrollBar.h"

@interface ViewController ()<SwitchViewScrollBarDelegate>
//@property (weak, nonatomic) ContainerController *container;
@property (weak, nonatomic) IBOutlet SwitchViewScrollBar *scrollBar;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong,nonatomic) NSMutableArray<UIViewController*>* controllers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollBar.titles = @[@"黑黑黑黑二维翁翁仍然",@"灰灰灰灰",@"绿绿绿绿",@"蓝蓝蓝蓝",@"橙橙橙橙"] ;
    
    // 初始化用于切换的控制器数组
    [self fillControllers:_scrollBar.titles];
    _scrollBar.delegate = self;
    
    [_scrollBar switchTo:0];
//    [self performSegueWithIdentifier:@"Container" sender:nil];
}
-(void)fillControllers:(NSArray<NSString*>*)titles{
    _controllers = [NSMutableArray new];
    
    for(int i = 0;i<titles.count;i++){
        UIViewController* vc= [[UIViewController alloc]init];
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 100)];
        v.backgroundColor=[UIColor whiteColor];
        [vc.view addSubview:v];
        switch (i) {
            case 0:
                vc.view.backgroundColor = [UIColor blackColor];
                break;
            case 1:
                vc.view.backgroundColor = [UIColor grayColor];
                break;
            case 2:
                vc.view.backgroundColor = [UIColor greenColor];
                break;
            case 3:
                vc.view.backgroundColor = [UIColor blueColor];
                break;
            case 4:
                vc.view.backgroundColor = [UIColor orangeColor];
                break;
            default:// 超出范围
                break;
        }
        [_controllers addObject:vc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"Container"]){
//        self.container = (ContainerController*)segue.destinationViewController;
//    }
//}

-(UIView*)containerViewInScrollBar:(SwitchViewScrollBar*)scrollBar{
    return self.containerView;
}
-(UIViewController*)scrollBar:(SwitchViewScrollBar*)scrollBar controllerAtIndex:(NSInteger)index{
    if(index>=0 && index<_controllers.count){
    
        return _controllers[index];
    }
    return nil;
}
@end
