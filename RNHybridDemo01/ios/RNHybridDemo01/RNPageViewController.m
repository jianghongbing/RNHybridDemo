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
    NSLog(@"self:%@:%@", self, self.navigationController);
    UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    [navigationController popViewControllerAnimated:YES];
}

RCT_EXPORT_METHOD(rnButtonClicked:(NSInteger)count) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了button" message:[NSString stringWithFormat:@"count:%ld", count] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}


+ (BOOL)requiresMainQueueSetup {
    return YES;
}

#pragma mark native
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RNPageThree";
    [self addRNPageThree];
}

- (void)addRNPageThree {
    NSURL *jsLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
    UIView *view = [[RCTRootView alloc] initWithBundleURL:jsLocation moduleName:@"RNPageThree" initialProperties:nil launchOptions:nil];
    self.view = view;
}

- (void)dealloc {
    NSLog(@"RNPageViewController dealloc");
}
@end
