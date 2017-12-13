//
//  XWZCodePayInputService.m
//  XWZPassword
//
//  Created by EUKaAccount on 2017/12/12.
//  Copyright © 2017年 Boat. All rights reserved.
//
// 图片路径
#define XWZCodePayInputServiceSrcName(file) [@"XWZCodePayInputService.bundle" stringByAppendingPathComponent:file]

#import "XWZCodePayInputService.h"
#import <XWZNumberBoxView/XWZNumberBoxView.h>
#import "XWZNumberBoxView.h"


@interface XWZCodePayInputService()<UITextFieldDelegate>
//
@property(nonatomic,strong) UIView *accessoryView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIImageView *loadingImage;
@property(nonatomic,strong) UILabel *loadingLabel;
@property(nonatomic,strong) XWZNumberBoxView *boxView;
//
@property(nonatomic,strong) UITextField *inputField;
@property(nonatomic,strong) UIView *backView;
@end

@implementation XWZCodePayInputService
- (UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_backView setBackgroundColor:[UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:0.5]];
    }
    return _backView;
}
- (UIView *)accessoryView {
    if (_accessoryView == nil) {
        _accessoryView = [[UIView alloc] init];
        _accessoryView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    }
    return _accessoryView;
}
- (XWZNumberBoxView *)boxView {
    if (_boxView == nil) {
        _boxView = [[XWZNumberBoxView alloc] init];
        _boxView.backgroundColor = [UIColor whiteColor];
        _boxView.boxNumber = 6;
        _boxView.secureTextEntry = YES;
        __weak typeof(self) weakSelf = self;
        _boxView.resultBlock = ^(NSString *boxs, BOOL isFull) {
            if (isFull) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (weakSelf.finishBlock) {
                        weakSelf.finishBlock(boxs);
                    }
                    [weakSelf startLoading];
                });
                
            } else {
                NSLog(@"boxes = %@",boxs);
            }
        };
    }
    return _boxView;
}
- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:XWZCodePayInputServiceSrcName(@"password_close@2x")] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"输入交易密码";
    }
    return _titleLabel;
}
- (UIImageView *)loadingImage {
    if (_loadingImage == nil) {
        _loadingImage = [[UIImageView alloc] init];
        _loadingImage.image = [UIImage imageNamed:XWZCodePayInputServiceSrcName(@"password_loading")];
        _loadingImage.contentMode = UIViewContentModeCenter;
    }
    return _loadingImage;
}
- (UILabel *)loadingLabel {
    if (_loadingLabel == nil) {
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.font = [UIFont systemFontOfSize:15];
        _loadingLabel.textColor = [UIColor lightGrayColor];
        _loadingLabel.textAlignment = NSTextAlignmentLeft;
        _loadingLabel.text = @"支付中...";
    }
    return _loadingLabel;
}
- (void)cancelBtnClicked {
    [self hide];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (UITextField *)inputField {
    if (_inputField == nil) {
        _inputField = [[UITextField alloc] init];
        _inputField.delegate = self;
        _inputField.keyboardType = UIKeyboardTypeNumberPad;
        _inputField.secureTextEntry = YES;
        _inputField.inputAccessoryView = self.accessoryView;
    }
    return _inputField;
}
- (instancetype)init {
    if (self = [super init]) {
        [self.backView addSubview:self.inputField];
        self.backView.alpha = 0;
        //
        self.accessoryView.frame = CGRectMake(0, 0, 0, 120);
        //
        [self.accessoryView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(0, 0, 40, 40);
        [self.accessoryView addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
        //
        self.loadingImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5 - 20, 60, 40, 40);
        [self.accessoryView addSubview:self.loadingImage];
        self.loadingLabel.frame = CGRectMake(CGRectGetMaxX(self.loadingImage.frame) + 20, 60, 100, 40);
        [self.accessoryView addSubview:self.loadingLabel];
        
        //
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - 40 * self.boxView.boxNumber) * 0.5;
        self.boxView.frame = CGRectMake(x, 60, 40 * self.boxView.boxNumber, 40);
        [self.accessoryView addSubview:self.boxView];

    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setLoadingText:(NSString *)loadingText {
    _loadingText = loadingText;
    self.loadingLabel.text = loadingText;
}
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    [_backView.superview bringSubviewToFront:_backView];
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.alpha = 1.f;
    }];
    [self.inputField becomeFirstResponder];
}
- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        self.backView.alpha = 0.f;
    }];
    [self.boxView clearBoxText];
    [self.inputField resignFirstResponder];
}
- (void)clearPassWord {
    [self.boxView clearBoxText];
}
- (void)startLoading {
    self.boxView.hidden = YES;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.loadingImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
- (void)stopLoading {
    self.boxView.hidden = NO;
    [self.loadingImage.layer removeAllAnimations];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length) {
        [self.boxView addCharacter:string];
    } else {
        [self.boxView deleteCharacter];
    }
    return YES;
}

@end
