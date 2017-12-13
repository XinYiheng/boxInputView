//
//  XWZNumberBox.m
//  XWZPassword
//
//  Created by EUKaAccount on 2017/12/12.
//  Copyright © 2017年 Boat. All rights reserved.
//

#import "XWZNumberBox.h"

@interface XWZNumberBox()
@property(nonatomic,strong) UIView *pointView;
@end
@implementation XWZNumberBox {
    NSString *_titleText;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pointView = [[UIView alloc] init];
        self.pointView.backgroundColor = [UIColor blackColor];
        self.pointView.hidden = YES;
        [self addSubview:self.pointView];
        self.textAlignment = NSTextAlignmentCenter;
        _secureTextEntry = YES;
    }
    return self;
}
// 覆盖夫类方法
- (void)setText:(NSString *)text {
    _titleText = text;
    if (_secureTextEntry == YES) {
        [super setText:@""];
        if (text.length) {
            self.pointView.hidden = NO;
        } else {
            self.pointView.hidden = YES;
        }
    } else {
        text = text.length ? text : @"";
        [super setText:text];
        self.pointView.hidden = YES;
    }
}
- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    [self setText:_titleText];
}
- (NSString *)text {
    return _titleText;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = MIN(self.frame.size.width, self.frame.size.height) * 0.33;
    self.pointView.frame= CGRectMake(0, 0, width, width);
    self.pointView.layer.cornerRadius = width * 0.5;
    self.pointView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

@end
