//
//  RNPagePreloadManager.h
//  RNHybridDemo01
//
//  Created by pantosoft on 2019/5/23.
//  Copyright © 2019 jianghongbing. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface RNPagePreloadManager : NSObject
@property (class, nullable, nonatomic, strong, readonly) RNPagePreloadManager *defaultManager;
- (void)preloadViewForRNModule:(nonnull NSString *)RNModuleName cacheKey:(nonnull NSString *)cacheKey;
- (void)preloadViewForRNModule:(nonnull NSString *)RNModuleName initialProperties:(nullable NSDictionary *)initialProperty cacheKey:(NSString *)cacheKey;
- (nullable UIView *)viewForKey:(NSString *)key;
- (void)removeView:(nonnull NSString *)key;
- (void)removAllPreloadView;
@end

NS_ASSUME_NONNULL_END
