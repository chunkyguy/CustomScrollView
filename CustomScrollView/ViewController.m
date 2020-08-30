//
//  ViewController.m
//  CustomScrollView
//
//  Created by Ole Begemann on 16.04.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "ViewController.h"
#import "CustomScrollView.h"

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.title = @"Custom Scroll View Demo";
  CGFloat width = CGRectGetWidth(self.view.bounds);
  CGFloat height = CGRectGetHeight(self.view.bounds);
  UIImage *image = [UIImage imageNamed:@"landscape"];
  UITextView *consoleView = [[UITextView alloc] initWithFrame:CGRectMake(0, width, width, height - width)];
  CustomScrollView *scrollView = [[CustomScrollView alloc] initWithFrame:CGRectMake(0, 0, width, width)
                                                             contentSize:image.size
                                                             consoleView:consoleView];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

  [self.view addSubview:consoleView];
  [self.view addSubview:scrollView];
  [scrollView addSubview:imageView];

  consoleView.editable = NO;
}

@end
