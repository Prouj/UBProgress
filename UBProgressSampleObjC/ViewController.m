//
//  ViewController.m
//  UBProgressSampleObjC
//
//  Created by Paulo Uchôa on 21/07/21.
//

#import "ViewController.h"
#import <UBProgress/UBProgress.h>


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UBProgress *progressBar0;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_progressBar0 setTypeText: UBProgressBarIndicatorTextDisplayModeFixedCenter];
    [_progressBar0 setTypeForm: UBProgressBarTypeCircle];
    [_progressBar0 setFont: [UIFont systemFontOfSize: 20]];
    [_progressBar0 setLabelTextColor: [UIColor colorWithRed:1.0 green:0.50 blue:0.50 alpha:1.0]];
    _progressBar0.circleProgressWidth = 5;
    _progressBar0.angle = 80;
    _progressBar0.rotationAngle = 50;
    
    
}
- (IBAction)stepperButton:(UIStepper*)sender {
    
    const CGFloat step = sender.value/100;
    
    [_progressBar0 setProgress: step animated:true];
    
}


@end
