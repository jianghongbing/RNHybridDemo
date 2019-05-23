//
//  ViewController.m
//  RNHybridDemo01
//
//  Created by pantosoft on 2019/5/22.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import "ViewController.h"
#import <React/RCTRootView.h>
#import "RNPageViewController.h"
#import "RNPagePreloadManager.h"
@interface ViewController ()

@end

static NSString * const kPreloadViewKey = @"myView";

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[RNPagePreloadManager defaultManager] preloadViewForRNModule:@"RNPageTwo" initialProperties:@{@"name": @"xiaoming", @"age": @10, @"id": @"007"} cacheKey:kPreloadViewKey];
}

- (IBAction)toRNPageOne:(id)sender {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"RNPageOne";
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    viewController.view = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"RNPageOne" initialProperties:nil launchOptions:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (IBAction)toRNPageTwo:(id)sender {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"RNPageOne";
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"RNPageTwo" initialProperties:@{@"name": @"xiaoming", @"age": @10, @"id": @"007"} launchOptions:nil];
    rootView.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    viewController.view = rootView;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)toRNPageThree:(id)sender {
    UIViewController *viewController = [[RNPageViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)preloadRNPage:(id)sender {
    UIViewController *viewController = [[UIViewController alloc] init];
    UIView *rootView = [[RNPagePreloadManager defaultManager] viewForKey:kPreloadViewKey];
    viewController.view = rootView;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)dealloc {
    [[RNPagePreloadManager defaultManager] removeView:kPreloadViewKey];
}

@end
