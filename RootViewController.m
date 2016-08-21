//
//  RootViewController.m
//  KVOByValue
//
//  Created by mac1 on 16/8/21.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "RootViewController.h"
#import "ModalViewControlller.h"

@interface RootViewController () {
    ModalViewControlller *_modalViewController;
}



@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1) 设置背景颜色
    self.view.backgroundColor = [UIColor cyanColor];
    
    //2) 设置一个Label
    //a) 创建一个Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 100, 270, 30)];
    //b) 设置该label的tag
    label.tag = 1000;
    //c) 设置label的内容
    label.text = @"观察者模式的传值";
    //d) 设置背景颜色
    label.backgroundColor = [UIColor orangeColor];
    //e) 设置字体颜色
    label.textColor = [UIColor whiteColor];
    //f) 设置居中方式
    label.textAlignment = NSTextAlignmentCenter;
    //g) 添加label
    [self.view addSubview:label];
    
    //3) 设置跳转你的button
    //a) 创建button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    //b) 设置其frame
    button.frame = CGRectMake(0, 0, 200, 30);
    //c) 设置其在屏幕的中心
    button.center = self.view.center;
    //d) 设置背景颜色
    button.backgroundColor = [UIColor lightGrayColor];
    //e) 设置显示的内容
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    //f) 设置相应事件
    [button addTarget:self
               action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    //g) 添加到页面上
    [self.view addSubview:button];
    
    //4) 初始化模态视图
    //a) 初始化模态视图
    _modalViewController = [[ModalViewControlller alloc] init];
    
    //b) 给模态视图定义一个观察者
    [_modalViewController addObserver:self
                           forKeyPath:@"textLabel"
                              options:NSKeyValueObservingOptionNew
                              context:nil];
    
}

#pragma mark - 点击的按键响应
- (void) buttonAction: (UIButton *) button {
    
    /**
     原因：模态视图在关闭的时候，已经被销毁了，但是观察者还在，就发生内存错误；所以就不能在这里定义模态视图以及观察者方法.
     解决：全局变量
     
     ModalViewController *modalViewController = [[ModalViewController alloc] init];
     modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
     [modalViewController addObserver:self
     forKeyPath:@"text"
     options:NSKeyValueObservingOptionNew
     context:nil];
     */
    
    _modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    //4. 模态视图
    [self presentViewController:_modalViewController animated:YES completion:nil];
    
}

#pragma mark - 观察者响应
- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary<NSString *,id> *)change
                        context:(void *)context {
    
    //    NSLog(@"old = %@, new = %@", [change objectForKey:@"old"], [change objectForKey:@"new"]);
    
    //1) 获取值得变化
    NSString *text = [change objectForKey:@"new"];
    
    //2) 通过tage获取label
    UILabel *label = (UILabel *) [self.view viewWithTag:1000];
    
    //3) 改变label的值
    label.text = text;
    
}

#pragma mark - 手动移除观察者
- (void) dealloc {
    [_modalViewController removeObserver:self forKeyPath:@"textLabel"];
}

@end
