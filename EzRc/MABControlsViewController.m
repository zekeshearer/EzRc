//
//  MABControlsViewController.m
//  EzRc
//
//  Created by Zeke Shearer on 3/31/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import "MABControlsViewController.h"
#import "MABMotionController.h"

@interface MABControlsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rollLabel;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *yawLabel;

@property (nonatomic, assign) BOOL isMotioning;

@end

@implementation MABControlsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startUpdates
{
    if ([[[MABMotionController instance] motionManager] isDeviceMotionAvailable] == YES) {
        [[[MABMotionController instance] motionManager] startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            self.rollLabel.text = [NSString stringWithFormat:@"%f", deviceMotion.attitude.roll];
            self.pitchLabel.text = [NSString stringWithFormat:@"%f", deviceMotion.attitude.pitch];
            self.yawLabel.text = [NSString stringWithFormat:@"%f", deviceMotion.attitude.yaw];
        }];
    }
}

- (void)stopUpdates
{
    [[[MABMotionController instance] motionManager] stopDeviceMotionUpdates];
}

- (IBAction)toggleMotionSensing:(id)sender
{
    if ( self.isMotioning ) {
        [self stopUpdates];
    } else {
        [self startUpdates];
    }
}

@end
