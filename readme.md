# 一个左右滑动的导航条控件

特点：

1. 支持左右滑动，在不同的文字标题之间切换。

	<img src = 'https://raw.githubusercontent.com/kmyhy/ScrollBar/master/1.png' width='300'/>

2. 自带传统的 Push 式 View Controller 转换动画。

	<img src='https://raw.githubusercontent.com/kmyhy/ScrollBar/master/2.png' width='300'/>

3. 防止抖动（频繁切换），在上一次转换动画结束前不允许再次切换。
4. 用法简单，只需要设置两个属性，并实现 2 个指定的协议方法。
5. 实现用轻扫手势来切换ViewController

## 用法

### 加入源文件
首先，将 ScrollBar.h/.m、SwitchViewScrollBar.h/.m、UIScrollView+UITouch.h/.m、UIViewController+Swipe.h/.m 拷贝到你的项目中。

然后在源文件中：#import "SwitchViewScrollBar.h"

### 实例化 SwitchViewScrollBar

1. 使用故事版

	在故事版中拖一个 UIView，设置 Class 为 SwitchViewScrollBar，并建立好对应的 IBOutlet 连接。
	
2. 使用代码

	调用 initWithFrame 方法进行实例化。
	

### 配置 SwitchViewScrollBar

在 ViewController 的 viewDidLoad 方法中：

```swift
	// 1
	_scrollBar.titles = @[@"黑黑黑黑",@"灰灰灰灰",@"绿绿绿绿",@"蓝蓝蓝蓝",@"橙橙橙橙"];
	[self fillControllers:_scrollBar.titles];
	// 2
    _scrollBar.delegate = self;
    // 3
    [_scrollBar switchTo:0];

```

1. 配置 SwitchViewScrollBar 的标题，每个标题表示一个 ViewController。
2. fillControllers 将根据 titles 数组来构建一个 view controller数组。方法的实现如下：

	```swift
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
	```
	出于演示目的，这里创建了 5 个不同背景色的 UIViewController。这些 view controller都保存到 controller 数组属性中。
	
3. 配置 SwitchViewScrollBar 的委托对象，以便在 ViewController 中实现 SwitchViewScrollBarDelegate 协议。
4. 默认显示第一个 ViewController。

### 实现 SwitchViewScrollBarDelegate 协议

在 ViewController 中实现 SwitchViewScrollBarDelegate 协议的两个必须方法：

```swift
// 1
-(UIView*)containerViewInScrollBar:(SwitchViewScrollBar*)scrollBar{
    return self.containerView;
}
// 2
-(UIViewController*)scrollBar:(SwitchViewScrollBar*)scrollBar controllerAtIndex:(NSInteger)index{
    if(index>=0 && index<_controllers.count){
    
        return _controllers[index];
    }
    return nil;
    
}
```

1. 这个方法用于指定子控制器要嵌入到哪个 UIView 中显示。
2. 这个方法根据指定的索引返回一个 view controller，以便动画显示。注意 SwitchViewScrollBar 不会缓存子控制器。你需要自己缓存(就像我们用一个 controllers 数组缓存了所有 view controller)，或者每次都重新创建一个新的 view controller 并返回。

## 定制 SwitchViewScrollBar

SwitchViewScrollBar 继承了 ScrollBar 类的所有属性，具体请参考 ScrollBar.h 头文件。



