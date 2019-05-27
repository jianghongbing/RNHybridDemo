//
//  RNUserDefaults.m
//  RNHybridDemo02
//
//  Created by pantosoft on 2019/5/24.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNUserDefaults.h"
#import <React/RCTBridgeModule.h>
@interface RNUserDefaults() <RCTBridgeModule>
@end



@implementation RNUserDefaults

//导出模块名
RCT_EXPORT_MODULE(UserDefaults)
//导出不带返回值的函数
RCT_EXPORT_METHOD(saveUserName:(NSString *)userName forKey:(NSString *)key) {
  [[NSUserDefaults standardUserDefaults] setObject:userName forKey:key];
}

//导出同步的带有返回值的函数
RCT_EXPORT_SYNCHRONOUS_TYPED_METHOD(NSString *, getUserNameForKey:(NSString *)key) {
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return userName;
}

//导出block

RCT_EXPORT_METHOD(queryUserNameForKey:(NSString *)key handler:(RCTResponseSenderBlock)handler) {
  NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:key];
  if (handler && userName) {
    handler(@[[NSNull null], userName]);
  }else {
    NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1000 userInfo:@{NSUnderlyingErrorKey:[NSString stringWithFormat:@"%@ is not exist", key]}];
    handler(@[error]);
  }
}

//导出Promise
//模拟导出promise
RCT_REMAP_METHOD(loadData, loadDataSuccess:(RCTPromiseResolveBlock)result failed:(RCTPromiseRejectBlock)failed) {
//  [self sendEventWithName:BEGIN_LOAD_DATA_EVENT body:nil];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    [self sendEventWithName:LOADING_DATA_EVENT body:nil];
    NSUInteger randomNumber = arc4random_uniform(100);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSLog(@"number:%ld", randomNumber);
      if (randomNumber > 50) {
        if (result) {
          result(@{@"data": @(randomNumber)});
        }
      }else {
        if (failed) {
          failed(@"100", @"load date failed", nil);
        }
      }
//      [self sendEventWithName:END_LOAD_DATA_EVENT body:nil];
    });
  });
}


//导出初始常量
- (NSDictionary *)constantsToExport {
  return @{@"userName": @"admin"};
}

//
+ (BOOL)requiresMainQueueSetup {
  return YES;
}

- (void)batchDidComplete {
  NSLog(@"method:%@", NSStringFromSelector(_cmd));
}

- (void)partialBatchDidFlush {
  NSLog(@"method:%@", NSStringFromSelector(_cmd));
}


@end
