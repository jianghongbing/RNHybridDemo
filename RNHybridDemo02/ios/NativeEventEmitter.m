//
//  NativeEventEmitter.m
//  RNHybridDemo02
//
//  Created by pantosoft on 2019/5/27.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "NativeEventEmitter.h"
//static NSString * const BEGIN_LOAD_DATA_EVENT = @"com.jianghongbing.begin_load_data";
//static NSString * const LOADING_DATA_EVENT = @"com.jianghongbing.loading_data";
//static NSString * const END_LOAD_DATA_EVENT = @"com.jianghongbing.end_load_data";
static NSString * const BEGIN_LOAD_DATA_EVENT = @"begin_load_data";
static NSString * const LOADING_DATA_EVENT = @"loading_data";
static NSString * const END_LOAD_DATA_EVENT = @"end_load_data";
@interface NativeEventEmitter()<RCTBridgeModule>

@end

@implementation NativeEventEmitter

RCT_EXPORT_MODULE(IOSEventEmitter)

RCT_EXPORT_METHOD(sendEvents) {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self sendEventWithName:BEGIN_LOAD_DATA_EVENT body:@{}];
  });
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self sendEventWithName:LOADING_DATA_EVENT body:nil];
  });
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self sendEventWithName:END_LOAD_DATA_EVENT body:nil];
  });
}

//事件相关
//发送事件给js
- (NSArray<NSString *> *)supportedEvents {
  return @[BEGIN_LOAD_DATA_EVENT, LOADING_DATA_EVENT, END_LOAD_DATA_EVENT];
}
- (void)startObserving {
  NSLog(@"method:%@", NSStringFromSelector(_cmd));

}

- (void)stopObserving {
  NSLog(@"method:%@", NSStringFromSelector(_cmd));

}

- (void)addListener:(NSString *)eventName {
  NSLog(@"method:%@ evnetName:%@", NSStringFromSelector(_cmd), eventName);

}

- (void)removeListeners:(double)count {
  NSLog(@"method:%@, count:%f", NSStringFromSelector(_cmd), count);

}
@end
