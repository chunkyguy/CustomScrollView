//
// Created by Sidharth Juyal on 30/08/2020.
// Copyright © 2020 Ole Begemann. All rights reserved.
//

#import "WLMath.h"
#import <GLKit/GLKit.h>

CGFloat wl_clamp(CGFloat value, CGFloat min, CGFloat max)
{
  return fmax(min, fmin(value, max));
}

CGRect wl_scrollZoom(CGRect frame, CGSize contentSize, CGFloat scale)
{
  GLKMatrix4 mat = GLKMatrix4Identity;
  CGPoint frameCenter = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));

  CGFloat scaleX = scale;
  CGFloat scaleY = scale;
  if (scale < 1) {
    scaleX = scale;
    scaleY = scale;
  }

  mat = GLKMatrix4Translate(mat, -frameCenter.x, -frameCenter.y, 0.0f);
  mat = GLKMatrix4Scale(mat, scaleX, scaleY, 1);
  mat = GLKMatrix4Translate(mat, frameCenter.x, frameCenter.y, 0.0f);

  CGPoint pts[] = {
    { frame.size.width / 2.0, frame.size.height / 2.0 },
    frameCenter,
    { contentSize.width - frame.size.width / 2.0, contentSize.height - frame.size.height / 2.0 }
  };

  GLKVector4 vecs[3] = {};
  for (int i = 0; i < 3; ++i) {
    GLKVector4 vecIn = GLKVector4Make(pts[i].x, pts[i].y, 0, 0);
    GLKVector4 vecOut = GLKMatrix4MultiplyVector4(mat, vecIn);
    vecs[i] = vecOut;
  }

  CGFloat x = wl_clamp(vecs[2].x, 0, vecs[1].x - frame.size.width / 2.0);
  CGFloat y = wl_clamp(vecs[2].y, 0, vecs[1].y - frame.size.height / 2.0);
  return CGRectMake(x, y, frame.size.width, frame.size.height);
}

CGRect wl_scrollTranslate(CGRect frame, CGSize contentSize, CGPoint translation)
{
  CGPoint delta = CGPointMake(frame.origin.x - translation.x,
    frame.origin.y - translation.y);
  CGPoint min = CGPointZero;
  CGPoint max = CGPointMake(contentSize.width - frame.size.width,
    contentSize.height - frame.size.height);
  CGFloat x = wl_clamp(delta.x, min.x, max.x);
  CGFloat y = wl_clamp(delta.y, min.y, max.y);
  return CGRectMake(x, y, frame.size.width, frame.size.height);
}
