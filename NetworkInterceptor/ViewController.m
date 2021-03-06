//
//  ViewController.m
//  NetworkInterceptor
//
//  Created by Georgios Taskos on 5/3/15.
//  Copyright (c) 2015 Xplat Solutions. All rights reserved.
//

#import "ViewController.h"
#import "XplatNetworkMonitorClient.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDataIntercepted:) name:kXPLNetworkMonitorNotification object:nil];
    
    [[XplatNetworkMonitorClient sharedInstance] startMonitoring];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://headers.jsontest.com/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) networkDataIntercepted:(NSNotification*)notification {
    if (notification) {
        if (notification.userInfo) {
            NetworkModel* networkData = [notification.userInfo objectForKey:kXPLNetworkMonitorDataKey];
            if (networkData) {
                NSLog(@"%@", networkData.description);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
