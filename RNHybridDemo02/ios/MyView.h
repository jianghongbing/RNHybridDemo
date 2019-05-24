//
//  MyView.h
//  RNHybridDemo02
//
//  Created by pantosoft on 2019/5/24.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyView : UIView
//@property (nonatomic) BOOL touchable;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic) NSInteger fontSize;
@property (nonatomic, copy) RCTBubblingEventBlock onClickHandler;
@end

NS_ASSUME_NONNULL_END
