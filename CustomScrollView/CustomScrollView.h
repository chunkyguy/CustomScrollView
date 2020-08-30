//
//  CustomScrollView.h
//  CustomScrollView
//
//  Created by Ole Begemann on 16.04.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIView

- (id)initWithFrame:(CGRect)frame consoleView:(UITextView *)consoleView;

@property (nonatomic) CGSize contentSize;

@end
