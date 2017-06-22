//
//  ViewController.m
//  CustomFloatWindow
//
//  Created by chenyong on 17/2/23.
//  Copyright © 2017年 chenyong. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "XHDraggableButton.h"

#define floatWindowSize 104.f
@interface ViewController ()<UIDragButtonDelegate>

@property (strong,nonatomic) UIWindow *window;
@property (nonatomic, strong) XHDraggableButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectZero;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createButton];
    });
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    _window.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _window.hidden = YES;
}

- (void)createButton
{
    // 1.floating button
    _button = [XHDraggableButton buttonWithType:UIButtonTypeCustom];
    [_button setImage:[UIImage imageNamed:@"红包-默认"] forState:UIControlStateNormal];
//        [self resetBackgroundImage:@"default_normal" forState:UIControlStateNormal];
//        [self resetBackgroundImage:@"default_selected" forState:UIControlStateSelected];
    _button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _button.frame = CGRectMake(0, 0, floatWindowSize, floatWindowSize);
    _button.buttonDelegate = self;
    _button.initOrientation = [UIApplication sharedApplication].statusBarOrientation;
    _button.originTransform = _button.transform;
//    _button.imageView.alpha = 0.8;
    _button.rootView = self.view.superview;
    
    // 2.floating window
    _window = [[UIWindow alloc]init];
    _window.frame = CGRectMake(0, 100, floatWindowSize, floatWindowSize);
    _window.windowLevel = UIWindowLevelAlert+1;
    _window.backgroundColor = [UIColor clearColor];
    _window.layer.cornerRadius = floatWindowSize/2;
    _window.layer.masksToBounds = YES;
    [_window addSubview:_button];
    [_window makeKeyAndVisible];
}

- (void)dragButtonClicked:(UIButton *)sender {
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 * notification
 */
- (void)orientationChange:(NSNotification *)notification {
    [_button buttonRotate];
}
@end
