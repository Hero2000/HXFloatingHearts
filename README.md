# HXFloatingHearts

[![CI Status](http://img.shields.io/travis/Insofan/HXFloatingHearts.svg?style=flat)](https://travis-ci.org/Insofan/HXFloatingHearts)
[![Version](https://img.shields.io/cocoapods/v/HXFloatingHearts.svg?style=flat)](http://cocoapods.org/pods/HXFloatingHearts)
[![License](https://img.shields.io/cocoapods/l/HXFloatingHearts.svg?style=flat)](http://cocoapods.org/pods/HXFloatingHearts)
[![Platform](https://img.shields.io/cocoapods/p/HXFloatingHearts.svg?style=flat)](http://cocoapods.org/pods/HXFloatingHearts)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 6.0

## ScreenShot

![i1XRI.gif](http://storage1.imgchr.com/i1XRI.gif)

## Installation

HXFloatingHearts is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HXFloatingHearts"
```

## Usage

1.Set view.userInteractionEnabled

```
self.view.userInteractionEnabled = YES;
```

2.Add tap gesture.

```
//添加轻触
UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(floatingHeart)];
[self.view addGestureRecognizer:tapGesture];
```

3.Animate heart

```
//启动动画
- (void)floatingHeart {
    HXFloatingHearts *heart = [[HXFloatingHearts alloc] initWithWidth:36 center:CGPointMake(138, self.view.bounds.size.height - 28)];
    heart.totalAnimationDuration = 8;
    [self.view addSubview:heart];
    CGPointMake(38, self.view.bounds.size.height - 36/2.0 - 10);
    [heart floatingHeartsWithView:self.view];
}
```



## Author

Insofan, insofan3156@gmail.com

## License

HXFloatingHearts is available under the MIT license. See the LICENSE file for more info.
