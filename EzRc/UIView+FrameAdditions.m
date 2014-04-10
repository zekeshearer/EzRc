//
//  UIView+FrameAdditions.m
//  EzRc
//
//  Created by Zeke Shearer on 4/9/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import "UIView+FrameAdditions.h"

@implementation UIView (FrameAdditions)

- (void)setWidth:(CGFloat)width
{
    CGRect frame;
    
    frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame;
    
    frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setXOrigin:(CGFloat)xOrigin
{
    CGRect frame;
    
    frame = self.frame;
    frame.origin.x = xOrigin;
    self.frame = frame;
}

- (void)setYOrigin:(CGFloat)yOrigin
{
    CGRect frame;
    
    frame = self.frame;
    frame.origin.y = yOrigin;
    self.frame = frame;
}

@end
