//
//  XWZNumberBoxView.m
//  XWZPassword
//
//  Created by EUKaAccount on 2017/12/12.
//  Copyright © 2017年 Boat. All rights reserved.
//



#import "XWZNumberBoxView.h"
#import "XWZNumberBox.h"

@interface UIView (BorderExtension)
- (void)setBorderTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(CGColorRef)color borderWidth:(CGFloat)width;
@end

@interface XWZNumberBoxView()
@property(nonatomic,strong) UITextField *boxField;
@property(nonatomic,strong) NSMutableArray <XWZNumberBox *>*subBoxViews;
@end

@implementation XWZNumberBoxView
- (UITextField *)boxField {
    if (_boxField == nil) {
        _boxField = [UITextField new];
        [self addSubview:_boxField];
    }
    return _boxField;
}
- (NSMutableArray *)subBoxViews {
    if (_subBoxViews == nil) {
        _subBoxViews = [NSMutableArray arrayWithCapacity:3];
    }
    return _subBoxViews;
}
- (instancetype)initWithFrame:(CGRect)frame withBoxType:(XWZNumberBoxType)boxType {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        _boxType = boxType;
        _secureTextEntry = YES;
        _boxNumber = 6;
        [self setUpSubviews];
    }
    return self;
}
- (void)setUpSubviews {
    [self.subBoxViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.subBoxViews removeAllObjects];
    for (int i = 0; i < _boxNumber; i++) {
        XWZNumberBox *box = [[XWZNumberBox alloc] init];
        box.tag = i;
        box.textColor = [UIColor grayColor];
        box.secureTextEntry = self.secureTextEntry;
        [box setBackgroundColor:[UIColor clearColor]];
        [self.subBoxViews addObject:box];
        [self addSubview:box];
    }
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat selfheight = self.frame.size.height;
    CGFloat selfwidth = self.frame.size.width;
    CGFloat space = 0;
    CGFloat width = 0;
    if (self.boxType == XWZNumberBoxBorderLine) {
        space = 0;
        width = selfwidth/self.boxNumber;
    } else {
        space = selfwidth/(self.boxNumber * 2 - 1);
        width = space;
    }
    CGFloat x = 0;
    for (int i = 0; i < self.subBoxViews.count; i++) {
        x = (space + width) * i;
        XWZNumberBox *box = self.subBoxViews[i];
        box.frame = CGRectMake(x, 0, width, selfheight);
        if (self.boxType == XWZNumberBoxBorderLine) {
            [box setBorderTop:YES left:YES bottom:YES right:NO borderColor:[UIColor blackColor].CGColor borderWidth:1];
            if (i == self.subBoxViews.count - 1) {
               [box setBorderTop:YES left:YES bottom:YES right:YES borderColor:[UIColor blackColor].CGColor borderWidth:1];
            }
        } else {
            [box setBorderTop:NO left:NO bottom:YES right:NO borderColor:[UIColor blackColor].CGColor borderWidth:1];
        }
        
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [self initWithFrame:frame withBoxType:XWZNumberBoxBorderLine])
    return self;
    return nil;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    for (XWZNumberBox *box in self.subBoxViews) {
        box.secureTextEntry = secureTextEntry;
    }
}
- (void)setBoxNumber:(NSInteger)boxNumber {
    _boxNumber = boxNumber;
    [self setUpSubviews];
    [self layoutIfNeeded];
    [self setNeedsLayout];
    
}

#pragma mark-- 增减操作
- (void)clearBoxText {
    NSInteger count = self.boxField.text.length;
    for (int i = 0; i < count; i++) {
        [self performDeleteCharacter];
    }
    if (self.resultBlock) {
        BOOL isFull = self.boxField.text.length == _boxNumber;
        self.resultBlock(self.boxField.text, isFull);
    }
}
- (void)setCharacters:(NSString *)character {
    NSInteger count = self.boxField.text.length;
    for (int i = 0; i < count; i++) {
        [self performDeleteCharacter];
    }
    NSInteger minCount = character.length < _boxNumber ? character.length : _boxNumber;
    for (int i = 0; i < minCount; i++) {
        NSString *boxStr = [character substringWithRange:NSMakeRange(i, 1)];
        [self performAddCharacter:boxStr];
    }
    if (self.resultBlock) {
        BOOL isFull = self.boxField.text.length == _boxNumber;
        self.resultBlock(self.boxField.text, isFull);
    }
}
- (void)addCharacter:(NSString *)character {
    [self performAddCharacter:character];
    if (self.resultBlock) {
        BOOL isFull = self.boxField.text.length == _boxNumber;
        self.resultBlock(self.boxField.text, isFull);
    }
}

- (void)deleteCharacter {
    [self performDeleteCharacter];
    if (self.resultBlock) {
        BOOL isFull = self.boxField.text.length == _boxNumber;
        self.resultBlock(self.boxField.text, isFull);
    }
}
- (void)performAddCharacter:(NSString *)character {
    if (character == nil || character.length >= 2) return;
    NSString *originStr = self.boxField.text ? self.boxField.text : @"";
    NSMutableString *mString = [[NSMutableString alloc] initWithString:originStr];
    if (mString.length >= _boxNumber) {
        return;
    }
    for (int i = 0; i < self.subBoxViews.count; i++) {
        if (mString.length == i) {
            XWZNumberBox *box = self.subBoxViews[i];
            [box setText:character];
        }
    }
    [mString appendString:character];
    self.boxField.text = mString.copy;
}
- (void)performDeleteCharacter {
    NSString *originStr = self.boxField.text ? self.boxField.text : @"";
    NSMutableString *mString = [[NSMutableString alloc] initWithString:originStr];
    if (mString.length <= 0) {
        return;
    }
    [mString deleteCharactersInRange:NSMakeRange(mString.length - 1, 1)];
    for (int i = 0; i < self.subBoxViews.count; i++) {
        if (mString.length == i) {
            XWZNumberBox *box = self.subBoxViews[i];
            [box setText:nil];
        }
    }
    self.boxField.text = mString.copy;
}
@end


@implementation UIView(BorderExtension)
- (void)setBorderTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(CGColorRef)color borderWidth:(CGFloat)width {
    //    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.frame.size.height);
        layer.backgroundColor = color;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        layer.backgroundColor = color;
        [self.layer addSublayer:layer];
    }
}

@end
