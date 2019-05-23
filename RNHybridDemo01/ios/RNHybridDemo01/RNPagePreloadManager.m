//
//  RNPagePreloadManager.m
//  RNHybridDemo01
//
//  Created by pantosoft on 2019/5/23.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import "RNPagePreloadManager.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
@interface RNPagePreloadManager()<RCTBridgeDelegate>
@property (nonatomic, strong) RCTBridge *bridge;
@property (nonatomic, strong) NSCache<NSString *, UIView *> *RNViewCache;
@end
@implementation RNPagePreloadManager
+ (RNPagePreloadManager *)defaultManager {
    static RNPagePreloadManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[RNPagePreloadManager alloc] init];
    });
    return defaultManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
        _RNViewCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)preloadViewForRNModule:(NSString *)RNModuleName cacheKey:(nonnull NSString *)cacheKey{
    [self preloadViewForRNModule:RNModuleName initialProperties:nil cacheKey:cacheKey];
}

- (void)preloadViewForRNModule:(NSString *)RNModuleName initialProperties:(NSDictionary *)initialProperties cacheKey:(nonnull NSString *)cacheKey{
    UIView *view = [[RCTRootView alloc] initWithBridge:self.bridge moduleName:RNModuleName initialProperties:initialProperties];
    [_RNViewCache setObject:view forKey:cacheKey];
    
}

- (UIView *)viewForKey:(NSString *)cacheKey {
    return [_RNViewCache objectForKey:cacheKey];
}

- (void)removeView:(NSString *)key {
    [_RNViewCache removeObjectForKey:key];
}

#pragma mark RCTBridgeDelegate
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
    return [NSURL
            URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
}

@end
