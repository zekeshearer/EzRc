//
//  MABMotionController.h
//  EzRc
//
//  Created by Zeke Shearer on 3/31/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MABMotionController : NSObject

+ (MABMotionController *)instance;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end
