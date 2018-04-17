//
//  ViewController.m
//  YFNewsView
//
//  Created by ios_yangfei on 2018/4/12.
//  Copyright © 2018年 jianghu3. All rights reserved.
//

#import "ViewController.h"
#import "YFNewsView.h"
#import "UIView+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    YFNewsView *newsView = [[YFNewsView alloc] initWithNewsCount:2 frame:CGRectMake(10, 100, 300, 90) scrollType:YFNewsViewScrollTypeCube];
    [self.view addSubview:newsView];
    newsView.backgroundColor = [UIColor redColor];
    newsView.dataSource = @[
                            
                            ];
    /*
     @{@"title":@"1"},
     @{@"title":@"2"},
     @{@"title":@"3"},
     @{@"title":@"4"},
     @{@"title":@"5"},
     @{@"title":@"6"},
     @{@"title":@"7"}
     */
}


@end
