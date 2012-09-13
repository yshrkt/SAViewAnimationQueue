//
//  SAViewController.m
//  SAViewAnimationQueueSample
//
//  Created by Yoshihiro Kato on 2012/09/13.
//  Copyright (c) 2012年 Yoshihiro Kato. All rights reserved.
//

#import "SAViewController.h"
#import "SAViewAnimationQueue.h"

@interface SAViewController () {
    UIView* _targetView;
}

@end

@implementation SAViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    _targetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _targetView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_targetView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Appear/Disappear 
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Animation Queue
    SAViewAnimationQueue* animQueue = [SAViewAnimationQueue queue];
    [animQueue addAnimationWithDuration:1.0
                              animations:^{
                                  _targetView.backgroundColor = [UIColor blueColor];
                              }];
    [animQueue addAnimationWithDuration:1.0
                              animations:^{
                                  _targetView.backgroundColor = [UIColor greenColor];
                              }];
    [animQueue addAnimationWithDuration:1.0
                              animations:^{
                                  _targetView.backgroundColor = [UIColor redColor];
                              }];
    [animQueue addAnimationWithDuration:0.5
                                   delay:0.1
                                 options:UIViewAnimationOptionCurveEaseInOut
                              animations:^{
                                  _targetView.center = CGPointMake(20, self.view.bounds.size.height-20);
                              } completion:^(BOOL finished) {
                                  ;
                              }];
    [animQueue addAnimationWithDuration:0.5
                                   delay:0.1
                                 options:UIViewAnimationOptionCurveEaseInOut
                              animations:^{
                                  _targetView.center = CGPointMake(self.view.bounds.size.width-20,
                                                                   self.view.bounds.size.height-20);
                              } completion:^(BOOL finished) {
                                  ;
                              }];
    [animQueue addAnimationWithDuration:0.5
                                  delay:0.1
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 _targetView.center = CGPointMake(self.view.bounds.size.width-20,
                                                                  20);
                             } completion:^(BOOL finished) {
                                 ;
                             }];
    [animQueue addAnimationWithDuration:0.5
                                  delay:0.1
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 _targetView.center = CGPointMake(20,
                                                                  20);
                             } completion:^(BOOL finished) {
                                 ;
                             }];
    [animQueue start];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
