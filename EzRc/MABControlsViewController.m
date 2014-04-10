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

@property (weak, nonatomic) IBOutlet UIView *progressContainerView;
@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

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
    self.progressContainerView.alpha = 0;
    self.progressView.layer.borderWidth = 1;
    self.progressView.layer.cornerRadius = 5;
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
    [self updateUI];
}

- (IBAction)toggleDeviceConnection:(id)sender
{
    if ( [[MABBluetoothController instance] isConnected] ) {
        [[MABBluetoothController instance] disconnect];
    } else {
        [[MABBluetoothController instance] connect];
        [self alertForPendingConnection];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidConnect:) name:MABDeviceConnectedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceConnectionDidFail:) name:MABDeviceConnectionFailedNotifiction object:nil];
    }
    [self updateUI];
}

- (void)updateUI
{
    if ( self.isMotioning ) {
        [self.goButton setTitle:@"STOP" forState:UIControlStateNormal];
    } else {
        [self.goButton setTitle:@"GO" forState:UIControlStateNormal];
    }
    
    if ( [[MABBluetoothController instance] isConnected]  ) {
        [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    } else {
        [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    }
}

- (void)alertForPendingConnection
{
    [UIView animateWithDuration:.2 animations:^{
        self.progressContainerView.alpha = 1;
    }];
}

- (void)deviceDidConnect:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self updateUI];
    [self hideConnectionAlertView];
}

- (void)deviceConnectionDidFail:(NSNotification *)notification
{
    [[[UIAlertView alloc] initWithTitle:@"Search Failed" message:@"Please reset the car and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self updateUI];
    [self hideConnectionAlertView];
}

- (void)hideConnectionAlertView
{
    [UIView animateWithDuration:.2 animations:^{
        self.progressContainerView.alpha = 0;
    }];
}

#pragma mark - Motion Controller Delegate

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
    
    if ( self.forwardButton.state == UIControlStateHighlighted ) {
        forward = 1;
        back = 0;
    }
    if ( self.backButton.state == UIControlStateHighlighted ) {
        forward = 0;
        back = 1;
    }
    
    [[MABBluetoothController instance] updateForLeft:left right:right forward:forward back:back];
}

@end
