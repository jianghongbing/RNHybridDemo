//
//  RNVMyViewManager.m
//  RNHybridDemo02
//
//  Created by pantosoft on 2019/5/24.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNVMyViewManager.h"
#import "MyView.h"
#import "RCTConvert+Color.h"
@implementation RNVMyViewManager

//导出模块, 在rn中使用的模块.
RCT_EXPORT_MODULE(RNVMyView)

//这里的view将会作为显示在rn界面上的view
- (UIView *)view {
  return [[MyView alloc] init];
}

//导出属性, 通过js来控制原生控件的属性
RCT_EXPORT_VIEW_PROPERTY(userInteractionEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(text, NSString *)
RCT_EXPORT_VIEW_PROPERTY(fontSize, NSInteger)
//RCT_CUSTOM_VIEW_PROPERTY(text, NSString *, MyView) {
//  [view setText:[RCTConvert NSString:json]];
//}

//自定义导出的属性, 当RCTConvert里面提供的方法满足不了你的需求的时候,可以通过类型来自定义转换数据
RCT_CUSTOM_VIEW_PROPERTY(textColor, UIColor *, MyView) {
  [view setTextColor:[RCTConvert UIColorFromHexString:json]];
}

//导出事件
RCT_EXPORT_VIEW_PROPERTY(onClickHandler, RCTBubblingEventBlock);

@end
