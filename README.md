# LimitInputTextControl
iOS 限制输入长度控件

[![CI Status](https://img.shields.io/travis/0x1306a94/LimitInputTextControl.svg?style=flat)](https://travis-ci.org/0x1306a94/LimitInputTextControl)
[![Version](https://img.shields.io/cocoapods/v/LimitInputTextControl.svg?style=flat)](https://cocoapods.org/pods/LimitInputTextControl)
[![License](https://img.shields.io/cocoapods/l/LimitInputTextControl.svg?style=flat)](https://cocoapods.org/pods/LimitInputTextControl)
[![Platform](https://img.shields.io/cocoapods/p/LimitInputTextControl.svg?style=flat)](https://cocoapods.org/pods/LimitInputTextControl)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

```Objective-C
// LimitTextView
LimitTextView *textView = [[LimitTextView alloc] initWithMaxLine:5 maxLength:1000];
textView.placeholder = @"请输入内容";
textView.placeholderColor = [UIColor blackColor];
textView.font = [UIFont systemFontOfSize:15];
textView.textColor = [UIColor orangeColor];
__weak typeof(self) weakSelf = self;
textView.didHeightChange = ^(CGFloat height) {
    __strong typeof(weakSelf) strongSelf = weakSelf;
    // relodheght
};

// LimitTextField
LimitTextField *textField = [[LimitTextField alloc] initWithMaxLength:10];
```

## Installation

LimitInputTextControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LimitInputTextControl'
```

## Author

0x1306a94, 0x1306a94@gmail.com

## License

LimitInputTextControl is available under the MIT license. See the LICENSE file for more info.


