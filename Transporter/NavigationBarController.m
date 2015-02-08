//
//  NavigationViewController.m
//  Transporter
//
//  Created by Phillip Caudell on 07/01/2015.
//  Copyright (c) 2015 Phillip Caudell. All rights reserved.
//

#import "NavigationBarController.h"
#import "PCAngularActivityIndicatorView.h"

@interface NavigationBarController ()

@property (readonly, strong) PCAngularActivityIndicatorView *activityIndicatorView;

@end

@implementation NavigationBarController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        
        self.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBarBackground = [UIView new];
    self.navigationBarBackground.backgroundColor = [UIColor redColor];
    [self.view.layer insertSublayer:self.navigationBarBackground.layer atIndex:1];
    
    [self.navigationBar setShadowImage:[UIImage imageNamed:@"NavigationBar-transparent"]];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBar-transparent"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"OpenSans" size:24]}];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    _activityIndicatorView = [[PCAngularActivityIndicatorView alloc] initWithActivityIndicatorStyle:PCAngularActivityIndicatorViewStyleLarge];
    self.activityIndicatorView.color = [UIColor whiteColor];
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.navigationBarBackground.frame = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    self.activityIndicatorView.center = self.view.center;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController respondsToSelector:@selector(navigationBarColor)]) {
        
        id vc = viewController;
        self.navigationBarBackground.backgroundColor = [vc navigationBarColor];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end

@implementation UIViewController (NavigationController)

- (void)setNeedsActivityIndicatorUpdate
{
    id viewController = self;
    BOOL isLoading = [viewController isLoading];
    NavigationBarController *navigationController = (NavigationBarController *)self.navigationController;
    
    if (isLoading) {
        [navigationController.activityIndicatorView startAnimating];
    } else {
        [navigationController.activityIndicatorView stopAnimating];
    }
}

- (BOOL)isLoading
{
    return NO;
}

@end
