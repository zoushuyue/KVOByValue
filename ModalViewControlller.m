//
//  ModalViewControlller.m
//  KVOByValue
//
//  Created by mac1 on 16/8/21.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "ModalViewControlller.h"

@interface ModalViewControlller ()

@end

@implementation ModalViewControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1) 设置背景颜色
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    //2) 设置一个TextField
    //a) 创建一个TextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(25, 100, 270, 30)];
    //b) 设置tag
    textField.tag = 2000;
    //c) 设置显示的效果
    textField.borderStyle = UITextBorderStyleRoundedRect;
    //d) 显示提示语
    textField.placeholder = @"请输入一段文字...";
    //e) 添加到self.view上
    [self.view addSubview:textField];
    
    
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
    [button setTitle:@"返 回" forState:UIControlStateNormal];
    //f) 设置相应事件
    [button addTarget:self
               action:@selector(backAction:)
     forControlEvents:UIControlEventTouchUpInside];
    //g) 添加到页面上
    [self.view addSubview:button];
    
}

- (void) backAction: (UIButton *) button {
    
    //1) 取值
    UITextField *textField = (UITextField *)[self.view viewWithTag:2000];
    
    //2) 修改值
    //注意观察者模式：如果定义成_textLabel = textField.text是无法启动观察者模式的。
    //原因：键值赋值方法只有：set方法、get方法(属性名同名，不带下划线)，才能赋值成功；
    //键值观察者在观察的时候也是这几种方法
    self.textLabel = textField.text;
    
    //3) 关闭模态视图
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
