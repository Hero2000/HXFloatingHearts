//
//  HXViewController.m
//  HXFloatingHearts
//
//  Created by Insofan on 04/19/2017.
//  Copyright (c) 2017 Insofan. All rights reserved.
//

#import "HXViewController.h"
#import <HXTool/HXTool.h>
#import <HXFloatingHearts/HXFloatingHearts.h>

@interface HXViewController ()
@property (strong, nonatomic) NSTimer *pressTimer;
@end

@implementation HXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"HXFloatingHearts";
	// Do any additional setup after loading the view, typically from a nib.
    
    //1.Set view.userInteractionEnabled
    self.view.userInteractionEnabled = YES;
    
    //2.Add tap gesture.
    //添加轻触
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(floatingHeart)];
    [self.view addGestureRecognizer:tapGesture];
    
    //4.More options.This is for long press and circle shape,长按触发圆形动画
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.2;
    [self.view addGestureRecognizer:longPressGesture];
}

//3.Animate heart.
//启动动画
- (void)floatingHeart {
    HXFloatingHearts *heart = [[HXFloatingHearts alloc] initWithWidth:36 center:CGPointMake(138, self.view.bounds.size.height - 28)];
    heart.totalAnimationDuration = 8;
    [self.view addSubview:heart];
    CGPointMake(38, self.view.bounds.size.height - 36/2.0 - 10);
    [heart floatingHeartsWithView:self.view];
}

- (void)floatingCircle {
    HXFloatingHearts *heart = [[HXFloatingHearts alloc] initWithWidth:36 center:CGPointMake(138, self.view.bounds.size.height - 28)];
    heart.totalAnimationDuration = 8;
    heart.isCircle = true;
    //Alter circle to randomShape,可以随机圆形心形
    //heart.isRandomShape = true;
    [self.view addSubview:heart];
    CGPointMake(38, self.view.bounds.size.height - 36/2.0 - 10);
    [heart floatingHeartsWithView:self.view];
}

-(void)longPressGesture:(UILongPressGestureRecognizer *)longPressGesture{
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
            _pressTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(floatingCircle) userInfo:nil repeats:YES];
            break;
        case UIGestureRecognizerStateEnded:
            [_pressTimer invalidate];
            _pressTimer = nil;
            break;
        default:
            break;
    }
}


@end
