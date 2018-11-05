//
//  LimitTextView.h
//  Pods
//
//  Created by king on 2018/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LimitTextView : UITextView
/** 最大行数 最小为1, 默认1 */
@property (nonatomic, assign) NSUInteger maxLine;
/** 最大长度 0 为无限制, 默认为0 */
@property (nonatomic, assign) NSUInteger maxLength;
/** 控件最小高度, 默认为 使用字体高度 */
@property (nonatomic, assign) CGFloat minHeight;
/** 占位文字 */
@property (nonatomic, strong) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) void(^didHeightChange)(CGFloat height);
/**
 实例化

 @param maxLine 最大行数 最小为1, 默认1
 @param maxLength 最大长度 0 为无限制, 默认为0
 @return LimitTextView instance
 */
- (instancetype)initWithMaxLine:(NSUInteger)maxLine
                      maxLength:(NSUInteger)maxLength NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
