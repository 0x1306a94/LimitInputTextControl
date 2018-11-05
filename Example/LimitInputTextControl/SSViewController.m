//
//  SSViewController.m
//  LimitInputTextControl
//
//  Created by 0x1306a94 on 11/04/2018.
//  Copyright (c) 2018 0x1306a94. All rights reserved.
//

#import "SSViewController.h"

#import <LimitInputTextControl/LimitInputTextControl.h>
#import <Masonry/Masonry.h>

@interface SSViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    LimitTextView *textView = [[LimitTextView alloc] initWithMaxLine:5 maxLength:0];
    textView.placeholder = @"请输入内容";
    textView.placeholderColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.textColor = [UIColor orangeColor];
    self.containerViewHeight.constant = textView.font.lineHeight + textView.textContainerInset.top + textView.textContainerInset.bottom + 20;
    __weak typeof(self) weakSelf = self;
    textView.didHeightChange = ^(CGFloat height) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.containerViewHeight.constant = height + 20;
    };
    
    [self.containerView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.containerView.mas_leading).offset(3);
        make.trailing.mas_equalTo(self.containerView.mas_trailing).offset(-3);
        make.top.mas_equalTo(self.containerView.mas_top).offset(10);
        make.bottom.mas_equalTo(self.containerView.mas_bottom).offset(-10);
    }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
