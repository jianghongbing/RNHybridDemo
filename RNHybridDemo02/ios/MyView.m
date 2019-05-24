//
//  MyView.m
//  RNHybridDemo02
//
//  Created by pantosoft on 2019/5/24.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "MyView.h"
@interface MyView()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic) NSInteger clickedCount;
@end
@implementation MyView
#pragma mark setter && getter
- (void)setText:(NSString *)text {
  if ([self.label.text isEqualToString:text]) return;
  self.label.text = text;
  [self.label sizeToFit];
  [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor {
  if ([self.label.textColor isEqual:textColor]) return;
  self.label.textColor = textColor;
}

- (void)setFontSize:(NSInteger)fontSize {
  if (_fontSize == fontSize) return;
  _fontSize = fontSize;
  self.label.font = [UIFont systemFontOfSize:fontSize];
}

- (UILabel *)label {
  if (_label == nil) {
    _label = [[UILabel alloc] init];
    [self addSubview:_label];
  }
  return _label;
}

- (UIButton *)button {
  if (_button == nil) {
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"Click Me" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _button.backgroundColor = self.tintColor;
    _button.layer.cornerRadius = 5;
    [_button sizeToFit];
    [self addSubview:_button];
  }
  return _button;
}

- (void)buttonClicked:(UIButton *)button {
  self.clickedCount++;
  if (self.onClickHandler) {
    self.onClickHandler(@{@"count": @(self.clickedCount)});
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect buttonFrame = self.button.frame;
  buttonFrame.origin.y = 10;
  self.button.frame = buttonFrame;
  CGPoint buttonCenter = self.button.center;
  buttonCenter.x = self.bounds.size.width * 0.5;
  self.button.center = buttonCenter;
  self.label.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 + 20);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  self.backgroundColor = [UIColor orangeColor];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  self.backgroundColor = [UIColor blueColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  self.backgroundColor = [UIColor greenColor];
}

@end
