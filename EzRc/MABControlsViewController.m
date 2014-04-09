//
//  MABControlsViewController.m
//  EzRc
//
//  Created by Zeke Shearer on 3/31/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import "MABControlsViewController.h"
#import "MABMotionController.h"
#import "MABBluetoothController.h"

@interface MABControlsViewController ()<MABMotionControllerDelegate>

@property (nonatomic, assign) BOOL isMotioning;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

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

- (IBAction)toggleMotionSensing:(id)sender
{
    if ( self.isMotioning ) {
        [[MABMotionController instance] stopUpdates];
    } else {
        [[MABMotionController instance] startUpdates];
        [MABMotionController instance].delegate = self;
    }
    self.isMotioning = !self.isMotioning;
}

- (IBAction)toggleDeviceConnection:(id)sender
{
    if ( [[MABBluetoothController instance] isConnected] ) {
        [[MABBluetoothController instance] disconnect];
    } else {
        [[MABBluetoothController instance] connect];
    }
}

- (void)motionController:(MABMotionController *)motionController didUpdateSteering:(CGFloat)steering throttle:(CGFloat)throttle;
{
    CGFloat left;
    CGFloat right;
    CGFloat forward;
    CGFloat back;
 
    left = steering < 0 ? fabsf(steering) : 0;
    right = steering > 0 ? fabsf(steering) : 0;
    forward = throttle > 0 ? fabsf(throttle) : 0;
    back = throttle < 0 ? fabsf(throttle) : 0;
    
    [[MABBluetoothController instance] updateForLeft:left right:right forward:forward back:back];
}

@end
