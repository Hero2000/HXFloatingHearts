//
//  HXFloatingHearts.m
//  Pods
//
//  Created by 海啸 on 2017/4/19.
//
//

#import "HXFloatingHearts.h"
#import "HXTool.h"
@interface HXFloatingHearts()

@end

@implementation HXFloatingHearts

- (instancetype)initWithWidth:(CGFloat )width center:(CGPoint)center {
    self = [super initWithFrame:CGRectMake(0, 0, width, width)];
    if (self) {
        //设置边缘颜色和填充颜色
        _strokeColor = [UIColor clearColor];
        _fillColor = [UIColor randomColor];
        //设置动画时间
        _totalAnimationDuration = 5;
        //默认心形
        _isCircle = false;
        _isRandomShape = false;
        
        self.backgroundColor = [UIColor clearColor];
        self.center = center;
        //设置anchorPoint 从原来0.5 0.5 到0.5 1.0
        self.layer.anchorPoint = CGPointMake(0.5, 1.0);
    }
    return self;
}



- (void)floatingHeartsWithView:(UIView *)view {
    NSTimeInterval totalAnimationDuration = self.totalAnimationDuration;
    CGFloat heartWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(view.bounds);
    CGFloat heartCenterX = self.center.x;
    
    //Set scale and alpha
    //设置scale缩放与否,alpha
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.alpha = 0;
    
    //Bloom 设置绽放动画
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //重置transform初始化
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.9;
    } completion:nil];
    
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1 - (2 * i);
    NSInteger rotationFraction = arc4random_uniform(10);
    //设置旋转动画
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeRotation(rotationDirection * M_PI/(16 + rotationFraction * 0.2));
    } completion:nil];
    
    //Set beziserPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.center];
    
    //Random end point.随机点
    CGPoint endPoint = CGPointMake(heartCenterX + (rotationDirection) * arc4random_uniform(2 * heartWidth), viewHeight/6.0 + arc4random_uniform(viewHeight / 4.0));
    
    //Random control points
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1 - (2 * j);
    
    //Random x and y for control points
    CGFloat xDelta = (heartWidth / 2.0 + arc4random_uniform(2 * heartWidth)) * travelDirection;
    CGFloat yDelta = MAX(endPoint.y ,MAX(arc4random_uniform(8 * heartWidth), heartWidth));
    CGPoint controlPoint1 = CGPointMake(heartCenterX + xDelta,  viewHeight - yDelta);
    CGPoint controlPoint2 = CGPointMake(heartCenterX - 2 * xDelta, yDelta);
    
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    //Key frame animation
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = path.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFrameAnimation.duration = totalAnimationDuration + endPoint.y / viewHeight;
    [self.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    //Alpha from superview
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)drawRect:(CGRect)rect {
   //设置圆形时.Is circle shape
    if (self.isCircle) {
        self.isRandomShape = false;
        [self drawCircle];
    } else if (self.isRandomShape){//随机形状心和圆各百分之五十，randomShape
        
        self.isCircle = false;
        NSInteger i = arc4random_uniform(2);
        
        if (i == 1) {
            [self drawCircle];
        }else {
            [self drawHeart:rect];
        }
        
    } else {//heart shape.
        [self drawHeart:rect];
    }
}

//画心.
- (void)drawHeart:(CGRect)rect {
    [_strokeColor setStroke];
    [_fillColor setFill];
    
    CGFloat drawingPadding = 4.0;
    CGFloat curveRadius = floor((CGRectGetWidth(rect) - 2*drawingPadding) / 4.0);
    
    //Creat path
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    
    //Start at bottom heart tip
    CGPoint tipLocation = CGPointMake(floor(CGRectGetWidth(rect) / 2.0), CGRectGetHeight(rect) - drawingPadding);
    [heartPath moveToPoint:tipLocation];
    
    //Move to top left start of curve
    CGPoint topLeftCurveStart = CGPointMake(drawingPadding, floor(CGRectGetHeight(rect) / 2.4));
    
    [heartPath addQuadCurveToPoint:topLeftCurveStart controlPoint:CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius)];
    
    //Create top left curve
    [heartPath addArcWithCenter:CGPointMake(topLeftCurveStart.x + curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:true];
    
    //Create top right curve
    CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
    [heartPath addArcWithCenter:CGPointMake(topRightCurveStart.x + curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:true];
    
    //Final curve to bottom heart tip
    CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
    [heartPath addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y + curveRadius)];
    
    [heartPath fill];
    
    heartPath.lineWidth = 1;
    heartPath.lineCapStyle = kCGLineCapRound;
    heartPath.lineJoinStyle = kCGLineCapRound;
    [heartPath stroke];
    
}

//画圆
- (void)drawCircle{
    [_strokeColor setStroke];
    [_fillColor setFill];
    
    //画圆圈
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat circleRadius = self.bounds.size.width/2;
    [path moveToPoint:CGPointMake(circleRadius, circleRadius)];
    //画圆圈,计算园的中心点，center是图层中心点x=self.bounds.size.width/2, y=self.bounds.size.height/2
    [path addArcWithCenter:CGPointMake(circleRadius, circleRadius) radius:circleRadius startAngle:0 endAngle:2*M_PI clockwise:true];
    [path fill];
    
    path.lineWidth = 1;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path stroke];
}

@end
