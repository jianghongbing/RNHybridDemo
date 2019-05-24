//
//  RCTConvert+Color.m
//  RNHybridDemo02
//
//  Created by pantosoft on 2019/5/24.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTConvert+Color.h"

@implementation RCTConvert (Color)
+ (UIColor *)UIColorFromHexString:(id)json {
  if (![json isKindOfClass:[NSString class]]) {
    return [RCTConvert UIColor:json];
  }
  NSString *hexString = json;
  if ([hexString hasPrefix:@"#"]) {
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
  }
  if (hexString.length == 5) {
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:hexString];
    [mutableString insertString:[hexString substringWithRange:NSMakeRange(2, 1)] atIndex:2];
    [mutableString insertString:[hexString substringWithRange:NSMakeRange(3, 1)] atIndex:4];
    [mutableString insertString:[hexString substringWithRange:NSMakeRange(4, 1)] atIndex:6];
    hexString = mutableString.copy;
  }

  NSScanner *scanner = [[NSScanner alloc] initWithString:hexString];
  unsigned hexInt;
  if (![scanner scanHexInt:&hexInt]) return [UIColor darkTextColor];
  int r = (hexInt >> 16) & 0xFF;
  int g = (hexInt >> 8) & 0xFF;
  int b = (hexInt) & 0xFF;
  
  return [UIColor colorWithRed:r / 255.0f
                         green:g / 255.0f
                          blue:b / 255.0f
                         alpha:1.0f];
}

@end
