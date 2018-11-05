//
//  LimitTextField.h
//  Pods
//
//  Created by king on 2018/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LimitTextField : UITextField
/** 最大输入字符长度 0 无限制, 默认为0 */
@property (nonatomic, assign) NSUInteger maxLength;

/**
 实例化

 @param maxLength 最大输入字符长度
 @return instance
 */
- (instancetype)initWithMaxLength:(NSUInteger)maxLength NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
