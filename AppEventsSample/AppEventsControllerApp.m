//
//  FirstViewController.m
//  platformTest
//
//  Created by Pu Guannan on 4/7/15.
//  Copyright (c) 2015 Pu Guannan. All rights reserved.
//

#import "AppEventsControllerApp.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppEventsControllerApp ()
@end

@implementation AppEventsControllerApp
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMain:(UIStoryboardSegue *)segue sender:(id) sender
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

@end
