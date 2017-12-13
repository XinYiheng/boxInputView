//
//  XWZCodePayInputService.h
//  XWZPassword
//
//  Created by EUKaAccount on 2017/12/12.
//  Copyright © 2017年 Boat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWZCodePayInputService : UIView
/** 正在请求时显示的文本 */
@property (nonatomic, copy) NSString *loadingText;
/** 完成的回调block */
@property (nonatomic, copy) void (^finishBlock) (NSString *password);
/** cancle block */
@property (nonatomic, copy) void (^cancelBlock) (void);

/** 密码框的标题 */
@property (nonatomic, copy) NSString *title;

/** 开始加载 */
- (void)startLoading;

/** 加载完成 */
- (void)stopLoading;

/** 加载完成 */
- (void)clearPassWord;

/** 隐藏密码框 */
- (void)hide;

/** 弹出密码框 */
- (void)show;

@end
