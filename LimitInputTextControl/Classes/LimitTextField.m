//
//  LimitTextField.m
//  Pods
//
//  Created by king on 2018/11/4.
//

#import "LimitTextField.h"

@implementation LimitTextField
- (void)dealloc
{
#if DEBUG
    NSLog(@"[%@ dealloc]", NSStringFromClass(self.class));
#endif
    [self removeTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (instancetype)init {
    if (self == [super init]) {
        self.maxLength = 0;
        [self setup];
    }
    return self;
}
- (instancetype)initWithMaxLength:(NSUInteger)maxLength {
    if (self == [super init]) {
        self.maxLength = maxLength;
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.maxLength = 0;
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        self.maxLength = 0;
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)textDidChange {
    NSString *toBeString = self.text;
    NSString *lang = [self.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
        // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (self.maxLength > 0 && toBeString.length > self.maxLength) {
                self.text = [toBeString substringToIndex:self.maxLength];
            }
        }
    } else {
        if (self.maxLength > 0 && toBeString.length > self.maxLength) {
            self.text = [toBeString substringToIndex:self.maxLength];
        }
    }
}
@end
