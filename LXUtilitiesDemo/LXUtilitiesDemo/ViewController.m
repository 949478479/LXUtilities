//
//  ViewController.m
//  LXUtilitiesDemo
//
//  Created by 冠霖环如 on 2017/9/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "ViewController.h"
#import "AlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a ni
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    [[AlertView new] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
