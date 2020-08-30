//
//  CustomScrollView.m
//  CustomScrollView
//
//  Created by Ole Begemann on 16.04.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "CustomScrollView.h"
#import "WLMath.h"

@interface CustomScrollView () {
  CGRect _originalBounds;
  CGRect _panStartBounds;
  UITextView *_consoleView;
  CGFloat _zoomScale;
  CGSize _contentSize;
}
@end

@implementation CustomScrollView

- (id)initWithFrame:(CGRect)frame
        contentSize:(CGSize)contentSize
        consoleView:(UITextView *)consoleView
{
  self = [super initWithFrame:frame];
  if (self == nil) {
    return nil;
  }

  _panStartBounds = CGRectZero;
  _zoomScale = 1.0;
  _contentSize = contentSize;
  _consoleView = consoleView;
  _originalBounds = self.bounds;

  [self setBackgroundColor:[UIColor whiteColor]];
  [self setClipsToBounds:YES];

  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(handlePanGesture:)];
  [self addGestureRecognizer:panGesture];

  UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
  [self addGestureRecognizer:pinchGesture];

  [self printInitalInfo];
  return self;
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
  switch (gestureRecognizer.state) {
  case UIGestureRecognizerStateBegan:
    [self printInfoForEventNamed:@"pinch begin"];
    break;

  case UIGestureRecognizerStateChanged:
    _zoomScale = gestureRecognizer.scale;
    self.bounds = wl_scrollZoom(_originalBounds, _contentSize, gestureRecognizer.scale);
    [self printInfoForEventNamed:@"pinch change"];
    break;

  case UIGestureRecognizerStateEnded:
    [self printInfoForEventNamed:@"pinch end"];
    break;

  case UIGestureRecognizerStateCancelled:
    [self printInfoForEventNamed:@"pinch cancel"];
    break;

  default:
    NSAssert(false, @"Unsupported state", gestureRecognizer);
    break;
  }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
  switch (gestureRecognizer.state) {
  case UIGestureRecognizerStateBegan:
    _panStartBounds = self.bounds;
    [self printInfoForEventNamed:@"pan begin"];
    break;

  case UIGestureRecognizerStateChanged:
    self.bounds = wl_scrollTranslate(_panStartBounds, _contentSize, [gestureRecognizer translationInView:self]);
    [self printInfoForEventNamed:@"pan change"];
    break;

  case UIGestureRecognizerStateEnded:
    [self printInfoForEventNamed:@"pan end"];
    break;

  default:
    NSAssert(false, @"Unsupported state", gestureRecognizer);
    break;
  }
}

- (void)printInitalInfo
{
  NSMutableArray *arr = [NSMutableArray array];

  [arr addObject:@"event"];
  [arr addObject:@"init"];

  [arr addObject:@"content-size"];
  [arr addObject:NSStringFromCGSize(_contentSize)];

  [arr addObject:@"bounds"];
  [arr addObject:NSStringFromCGRect(self.bounds)];

  [arr addObject:@"zoom-scale"];
  [arr addObject:[NSNumber numberWithDouble:_zoomScale]];

  [arr addObject:@"original-bounds"];
  [arr addObject:NSStringFromCGRect(_originalBounds)];

  [self printData:arr];
}

- (void)printInfoForEventNamed:(NSString *)eventName
{
  NSMutableArray *arr = [NSMutableArray array];

  [arr addObject:@"event"];
  [arr addObject:eventName];

  [arr addObject:@"bounds"];
  [arr addObject:NSStringFromCGRect(self.bounds)];

  [arr addObject:@"zoom-scale"];
  [arr addObject:[NSNumber numberWithDouble:_zoomScale]];

  [self printData:arr];
}

- (void)printData:(NSArray *)arr
{
  NSMutableString *text = [NSMutableString string];
  for (NSInteger idx = 0; idx < [arr count]; idx += 2) {
    [text appendFormat:@"%@:%@\n", [arr objectAtIndex:idx], [arr objectAtIndex:idx + 1]];
  }
  [text appendString:_consoleView.text];
  _consoleView.text = text;
}

@end
