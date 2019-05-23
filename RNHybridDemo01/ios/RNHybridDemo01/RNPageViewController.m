//
//  RNPageViewController.m
//  RNHybridDemo01
//
//  Created by pantosoft on 2019/5/23.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import "RNPageViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTBridgeModule.h>
@interface RNPageViewController ()<RCTBridgeModule>

@end

@implementation RNPageViewController
#pragma mark RCTBridgeModule
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()
RCT_EXPORT_METHOD(goBack){
    NSLog(@"dismiss...self:%@:%@", self, self.navigationController);
    [self.navigationController popViewControllerAnimated:YES];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

#pragma mark native
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RNPageThree";
    [self addRNPageThree];
    NSLog(@"dismiss...self:%@:%@", self, self.navigationController);
}

- (void)addRNPageThree {
    NSURL *jsLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
    UIView *view = [[RCTRootView alloc] initWithBundleURL:jsLocation moduleName:@"RNPageThree" initialProperties:nil launchOptions:nil];
    self.view = view;
}

//- (void)goBack {
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
