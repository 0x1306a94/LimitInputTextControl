//
//  LimitTextView.m
//  Pods
//
//  Created by king on 2018/11/4.
//

#import "LimitTextView.h"

@interface LimitTextView ()
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, assign) CGFloat prevHeight;
@property (nonatomic, assign) CGFloat maxHeight;
@end

@implementation LimitTextView
- (void)dealloc
{
#if DEBUG
    NSLog(@"[%@ dealloc]", NSStringFromClass(self.class));
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    self.didHeightChange = nil;
}
- (instancetype)init {
    if (self == [super init]) {
        self.maxLine = 1;
        self.maxLength = 0;
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.maxLine = 1;
        self.maxLength = 0;
        [self setup];
    }
    return self;
}
- (instancetype)initWithMaxLine:(NSUInteger)maxLine maxLength:(NSUInteger)maxLength {
    if (self == [super init]) {
        self.maxLine = maxLine > 0 ? maxLine : 1;
        self.maxLength = maxLength;
        [self setup];
    }
    return self;
}

#pragma mark - override method
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    self.placeholderLabel.hidden = text.length > 0;
}
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}
- (CGFloat)maxHeight {
    return self.font.lineHeight * self.maxLine + self.textContainerInset.top + self.textContainerInset.bottom;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderLabel.frame = ({
        CGRect rect = CGRectZero;
        rect.origin.x = self.textContainerInset.left + 3;
        rect.origin.y = self.textContainerInset.top;
        rect.size.height = self.font.lineHeight;
        rect.size.width = CGRectGetWidth(self.bounds) - self.textContainerInset.left - self.textContainerInset.right;
        rect;
    });
}

#pragma mark - 初始化
- (void)setup {
    self.scrollEnabled = NO;
    self.enablesReturnKeyAutomatically = YES;
    [self addSubview:self.placeholderLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

- (void)textDidChange:(NSNotification *)notification {
    if (notification.object != self) return;
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
    self.placeholderLabel.hidden = self.text.length > 0;
    CGFloat minHeight = 0;
    if (self.minHeight <= 0) {
        minHeight = self.font.lineHeight + self.textContainerInset.top + self.textContainerInset.bottom;
    } else {
        minHeight = self.minHeight;
    }
    CGFloat height = 0;
    if (self.text.length == 0 || self.maxLine <= 1) {
        height = minHeight;
    } else {
        height = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), MAXFLOAT)].height;
        if (height <= minHeight) {
            height = minHeight;
        } else if (height >= self.maxHeight) {
            height = self.maxHeight;
        }
    }
    self.scrollEnabled = height >= self.maxHeight;
    // 避免多次重复刷新布局
    if (self.prevHeight == height) {
        return;
    }
    self.prevHeight = height;
    !self.didHeightChange ?: self.didHeightChange(height);
}

#pragma mark - lazy
- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
    }
    return _placeholderLabel;
}

@end
