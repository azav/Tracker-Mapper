//
//  LoadingViewController.m
//  Tracker Mapper
//
//  Created by Alex Zavatone on 8/17/17.
//  Copyright © 2017 Alex Zavatone. All rights reserved.
//

#import "LoadingViewController.h"
#import "MainCollectionViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"Main Navigation Controller"];
    
    [self presentViewController:navController animated:NO completion:^{
        nil;
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
