//
//  ViewController.m
//  XWZPassword
//
//  Created by EUKaAccount on 2017/12/12.
//  Copyright © 2017年 Boat. All rights reserved.
//

#import "ViewController.h"
#import "XWZNumberBoxView.h"
#import "XWZCodePayInputService.h"

@interface ViewController ()

@end

@implementation ViewController {
    XWZNumberBoxView *_boxView;
    XWZCodePayInputService *_service;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a 
    
    XWZCodePayInputService *service = [[XWZCodePayInputService alloc] init];
    _service = service;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_service show];
}

@end
