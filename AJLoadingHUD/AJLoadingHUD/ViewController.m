//
//  ViewController.m
//  AJLoadingHUD
//
//  Created by Arki-J on 2018/10/12.
//  Copyright © 2018 Arki-J. All rights reserved.
//

#import "ViewController.h"
#import "AJLoadingHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"AJLoadingHUD";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"start" style:UIBarButtonItemStylePlain target:self action:@selector(showLoading)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"stop" style:UIBarButtonItemStylePlain target:self action:@selector(stopLoading)];
}
-(void)showLoading{
    [AJLoadingHUD showIn:self.view];
}
-(void)stopLoading{
    [AJLoadingHUD hideIn:self.view];
}
@end
