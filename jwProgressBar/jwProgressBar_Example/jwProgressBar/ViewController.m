//
//  ViewController.m
//  jwProgressBar
//
//  Created by JW_N on 16/9/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "jwProgressBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    jwRingProgressBar *jrpb = [[jwRingProgressBar alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    jrpb.percent = 0.98;
    [self.view addSubview:jrpb];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
