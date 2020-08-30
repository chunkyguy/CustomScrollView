//
//  CustomScrollView.m
//  CustomScrollView
//
//  Created by Ole Begemann on 16.04.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "CustomScrollView.h"

CGFloat clamp(CGFloat value, CGFloat min, CGFloat max)
{
  return fmax(min, fmin(value, max));
}

@interface CustomScrollView () {
  CGRect _startBounds;
  UITextView *_consoleView;
}
@end

@implementation CustomScrollView

- (id)initWithFrame:(CGRect)frame consoleView:(UITextView *)consoleView
{
  self = [super initWithFrame:frame];
  if (self == nil) {
    return nil;
  }

  _startBounds = CGRectZero;
  _consoleView = consoleView;

  UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
  [self addGestureRecognizer:panGestureRecognizer];
  [self setBackgroundColor:[UIColor whiteColor]];
  [self setClipsToBounds:YES];

  [self printInfo];

  return self;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
  switch (panGestureRecognizer.state) {
    case UIGestureRecognizerStateBegan:
      _startBounds = self.bounds;
      break;

    case UIGestureRecognizerStateChanged:
      [self updateBoundsWithTranslation:[panGestureRecognizer translationInView:self]];
      break;

    case UIGestureRecognizerStateEnded:
      [self printInfo];
      break;

    default:
      break;
  }
}

- (void)updateBoundsWithTranslation:(CGPoint)translation
{
  CGRect bounds = _startBounds;
  CGPoint delta = CGPointMake(bounds.origin.x - translation.x,
                              bounds.origin.y - translation.y);
  CGPoint min = CGPointZero;
  CGPoint max = CGPointMake(_contentSize.width - bounds.size.width,
                            _contentSize.height - bounds.size.height);
  bounds.origin.x = clamp(delta.x, min.x, max.x);
  bounds.origin.y = clamp(delta.y, min.y, max.y);
  self.bounds = bounds;
}

- (void)printInfo
{
  NSString *text = [NSString stringWithFormat:@"bounds: %@", NSStringFromCGRect(self.bounds)];
  _consoleView.text = [NSString stringWithFormat:@"%@\n%@", text, _consoleView.text];
}

@end
