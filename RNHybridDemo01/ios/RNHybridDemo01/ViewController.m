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
@interface ViewController ()

@end

@implementation ViewController

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

@end
