//
//  RCTConvert+Color.h
//  RNHybridDemo02
//
//  Created by pantosoft on 2019/5/24.
//  Copyright © 2019 Facebook. All rights reserved.
//
#import <React/RCTConvert.h>
NS_ASSUME_NONNULL_BEGIN

@interface RCTConvert (Color)
+ (nonnull UIColor *)UIColorFromHexString:(id)json;
@end

NS_ASSUME_NONNULL_END
