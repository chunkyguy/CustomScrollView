//
// Created by Sidharth Juyal on 30/08/2020.
// Copyright © 2020 Ole Begemann. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

CGFloat wl_clamp(CGFloat value, CGFloat min, CGFloat max);
CGRect wl_scrollZoom(CGRect frame, CGSize contentSize, CGFloat scale);
CGRect wl_scrollTranslate(CGRect frame, CGSize contentSize, CGPoint translation);
