//
//  XWZNumberBoxView.h
//  XWZPassword
//
//  Created by EUKaAccount on 2017/12/12.
//  Copyright © 2017年 Boat. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XWZNumberBoxBorderLine,
    XWZNumberBoxBorderBottomLine
} XWZNumberBoxType;



@interface XWZNumberBoxView : UIView
// default XWZNumberBoxBorderLine
@property(nonatomic,assign,readonly) XWZNumberBoxType boxType;
// default Yes
@property(nonatomic,assign,getter=secure) BOOL secureTextEntry;
// default six
@property(nonatomic,assign) NSInteger boxNumber;

@property(nonatomic,copy) void(^resultBlock)(NSString *boxs, BOOL isFull);
// 文字
@property(nonatomic,assign,readonly) NSString *boxText;



- (instancetype)initWithFrame:(CGRect)frame withBoxType:(XWZNumberBoxType)boxType;
- (void)clearBoxText;
- (void)addCharacter:(NSString *)character;
- (void)deleteCharacter;
- (void)setCharacters:(NSString *)character;

@end
