//
//  HXFloatingHearts.h
//  Pods
//
//  Created by 海啸 on 2017/4/19.
//
//

#import <UIKit/UIKit.h>

@interface HXFloatingHearts : UIView
//Init framework frame & hearts center, center y must > self.view.frame.size.height - 80
- (instancetype)initWithWidth:(CGFloat )width center:(CGPoint )center;

- (void)floatingHeartsWithView:(UIView *)view;

//options
//边缘颜色，默认白色.default is clear
@property (strong, nonatomic) UIColor    *strokeColor;
//填充颜色，默认随机.default is random
@property (strong, nonatomic) UIColor    *fillColor;
//动画总的时间.default is 5
@property (assign, nonatomic) NSUInteger totalAnimationDuration;
//是圆形还是心形
@property (assign, nonatomic) BOOL isCircle;
//随机圆形心形
@property (assign, nonatomic) BOOL isRandomShape;
@end
