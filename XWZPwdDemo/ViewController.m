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
    __weak typeof(self) weakSelf = self;
    _service.finishBlock = ^(NSString *password) {
        [weakSelf startLoading];
    };
    
}
- (void)startLoading {
    [_service startLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_service stopLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_service clearPassWord];
        });
    });
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_service show];
}

@end
