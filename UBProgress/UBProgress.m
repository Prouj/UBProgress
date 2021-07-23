//
//  UBProgress.m
//  UBProgress
//
//  Created by Paulo Uchôa on 20/07/21.
//


#import "UBProgress.h"

// Sizes
const NSInteger UBProgressBarDefaultSizeInset = 1; //px

// Animation times
const NSTimeInterval UBProgressBarProgressTime = 0.25f; // s

// Default progress value
const CGFloat UBProgressBarDefaultProgress = 0.3f;

@interface UBProgress ()
@property (nonatomic, assign) CGFloat internalCornerRadius;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSTimer *progressTargetTimer;
@property (nonatomic, assign) CGFloat progressTargetValue;

// Init the progress bar with the default values.
- (void)initializeProgressBar;

// Draw the background (track) of the slider.
- (void)drawBackground:(CGContextRef)context withRect:(CGRect)rect;

// Draw the progress bar.
- (void)drawProgressBar:(CGContextRef)context withInnerRect:(CGRect)innerRect outterRect:(CGRect)outterRect;

// Draw the given text into the given location of the rect.
- (void)drawText:(CGContextRef)context withRect:(CGRect)rect;

// Callback for the setProgress:Animated: animation timer.
- (void)updateProgressWithTimer:(NSTimer *)timer;

@end

@implementation UBProgress
@synthesize progress = _progress;

- (void)dealloc {
    NSLog(@"dealloc !!!");
    
    if (_progressTargetTimer && [_progressTargetTimer isValid]) {
        [_progressTargetTimer invalidate];
    }
}

- (id)initWithFrame:(CGRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        [self initializeProgressBar];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initializeProgressBar];
    }
    return self;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    if (_progressTargetTimer && [_progressTargetTimer isValid]) {
        [_progressTargetTimer invalidate];
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.isHidden) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Refresh the corner radius value
    self.internalCornerRadius = 0;

    if (_cornerRadius > 0) {
        self.internalCornerRadius = _cornerRadius;
    }
    // Draw the background track
    if (!_hideTrack) {
        [self drawBackground:context withRect:rect];
    }
    
    // Compute the inner rectangle
    CGRect innerRect;
    
    innerRect = CGRectMake(_progressBarInset,
                           _progressBarInset,
                           CGRectGetWidth(rect) * self.progress - 2 * _progressBarInset,
                           CGRectGetHeight(rect) - 2 * _progressBarInset);
    
    CGRect centerRect;
    
    centerRect = CGRectMake(0,
                            0,
                            CGRectGetWidth(rect),
                            CGRectGetHeight(rect));

    [self drawProgressBar:context withInnerRect:innerRect outterRect:rect];
    
    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeFixCenter) {
        [self drawText:context withRect:centerRect];
    }
    
    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeProgressRight) {
        [self drawText:context withRect:innerRect];
        _indicatorTextLabel.textAlignment = NSTextAlignmentRight;
    }

    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeProgressCenter) {
        [self drawText:context withRect:innerRect];
    }
    
    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeFixedRight) {
        [self drawText:context withRect:rect];
        _indicatorTextLabel.textAlignment = NSTextAlignmentRight;
    }
}

#pragma mark - Properties
//
//- (void)setType:(YLProgressBarType)type {
//  _type = type;
//
//  switch (type) {
//    case YLProgressBarTypeRounded:
//      _hideGloss = NO;
//      break;
//    default:
//      _hideGloss = YES;
//      break;
//  }
//}

- (CGFloat)progress {
    @synchronized (self) {
        return _progress;
    }
}

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:YES];
}


- (void)setBehavior:(UBProgressBarBehavior)behavior {
    _behavior = behavior;
    
    [self setNeedsDisplay];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    progressTintColor  = (progressTintColor) ? progressTintColor : [UIColor blueColor];
    _progressTintColor = progressTintColor;

    [self setProgressTintColors:@[_progressTintColor, _progressTintColor]];
}

- (void)setProgressTintColors:(NSArray *)progressTintColors {
    NSAssert(progressTintColors, @"progressTintColors must not be null");
    NSAssert([progressTintColors count], @"progressTintColors must contain at least one element");
    
    if (_progressTintColors != progressTintColors) {
        _progressTintColors = progressTintColors;
    }
    
    NSMutableArray *colors  = [NSMutableArray arrayWithCapacity:[progressTintColors count]];
    for (UIColor *color in progressTintColors) {
        [colors addObject:(id)color.CGColor];
    }
    self.colors = colors;
}

#pragma mark - Public Methods

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    @synchronized (self) {
        if (_progressTargetTimer && [_progressTargetTimer isValid]) {
            [_progressTargetTimer invalidate];
        }
        
        CGFloat newProgress = progress;
        if (newProgress > 1.0f) {
            newProgress = 1.0f;
        } else if (newProgress < 0.0f) {
            newProgress = 0.0f;
        }
        
        if (animated) {
            _progressTargetValue = newProgress;
            CGFloat incrementValue = ((_progressTargetValue - _progress) * (1.0f / 30.0f))/ UBProgressBarProgressTime;
            
            if (incrementValue == 0) {
                return;
            }
            
            self.progressTargetTimer = [NSTimer timerWithTimeInterval:1.0f / 30.0f
                                                               target:self
                                                             selector:@selector(updateProgressWithTimer:)
                                                             userInfo:[NSNumber numberWithFloat:incrementValue]
                                                              repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_progressTargetTimer forMode:NSRunLoopCommonModes];
        } else {
            _progress = newProgress;
            
            [self setNeedsDisplay];
        }
    }
}

- (void)setTypeText:(UBProgressBarIndicatorTextDisplayMode)typeText {
    //  _type = typeText;

    switch (typeText) {
        case 1:
            _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeFixCenter;
            break;
        case 2:
            _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeProgressRight;
            break;
        case 3:
            _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeProgressCenter;
            break;
        case 4:
            _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeFixedRight;
            break;
        default:
            _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeNone;
            break;
    }
}


#pragma mark - Private Methods

- (void)updateProgressWithTimer:(NSTimer *)timer {
    CGFloat dt_progress = [timer.userInfo floatValue];
    
    _progress += dt_progress;
    
    if ((dt_progress < 0 && _progress <= _progressTargetValue)
        || (dt_progress > 0 && _progress >= _progressTargetValue)) {

        [_progressTargetTimer invalidate];
        _progressTargetTimer = nil;
        
        _progress = _progressTargetValue;
    }
    [self setNeedsDisplay];
}

- (void)initializeProgressBar {
    //    _type
    _progress        = UBProgressBarDefaultProgress;
    _hideTrack       = NO;
    _behavior        = UBProgressBarBehaviorDefault;
    _cornerRadius    = 0;
    
    _indicatorTextLabel                           = [[UILabel alloc] initWithFrame:self.frame];
    _indicatorTextLabel.adjustsFontSizeToFitWidth = YES;
    _indicatorTextLabel.backgroundColor           = [UIColor clearColor];
    _indicatorTextLabel.lineBreakMode             = NSLineBreakByTruncatingHead;
    _indicatorTextLabel.font = [UIFont fontWithName: @"System" size: 20];
    _indicatorTextLabel.textAlignment             = NSTextAlignmentCenter;
    _indicatorTextLabel.textColor                 = [UIColor clearColor];
    _indicatorTextLabel.minimumScaleFactor        = 3;
    
    _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeNone;
    
    self.trackTintColor           = [UIColor blackColor];
    self.progressTintColor        = self.backgroundColor;
    self.progressBarInset         = UBProgressBarDefaultSizeInset;
    self.backgroundColor          = [UIColor clearColor];
}


- (void)drawBackground:(CGContextRef)context withRect:(CGRect)rect {
    // Define the progress bar pattern to clip all the content inside
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))
    cornerRadius:_internalCornerRadius];
    [roundedRect addClip];
    
    CGContextSaveGState(context); {
        CGFloat trackWidth  = CGRectGetWidth(rect);
        CGFloat trackHeight = CGRectGetHeight(rect);
        
        if (_type == UBProgressBarTypeRounded) {
            trackHeight -= 1;
            trackWidth  -= 1;
        }
        
        // Draw the track
        UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, trackWidth, trackHeight) cornerRadius:_internalCornerRadius];
        [_trackTintColor set];
        [roundedRect fill];
    }
    CGContextRestoreGState(context);
}

- (void)drawProgressBar:(CGContextRef)context withInnerRect:(CGRect)innerRect outterRect:(CGRect)outterRect {
    CGRect gradientRect = innerRect;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextSaveGState(context); {
        UIBezierPath *progressBounds = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:_internalCornerRadius];
        CGContextAddPath(context, [progressBounds CGPath]);
        CGContextClip(context);
        
        CFArrayRef colorRefs  = (__bridge CFArrayRef)_colors;
        NSUInteger colorCount = [_colors count];
        
        CGFloat delta      = 1.0f / [_colors count];
        CGFloat semi_delta = delta / 2.0f;
        CGFloat locations[colorCount];
        
        for (NSInteger i = 0; i < colorCount; i++) {
            locations[i] = delta * i + semi_delta;
        }
        
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colorRefs, locations);
        
        CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMinX(gradientRect), CGRectGetMinY(gradientRect)), CGPointMake(CGRectGetMinX(gradientRect) + CGRectGetWidth(gradientRect), CGRectGetMinY(gradientRect)), (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
        
        CGGradientRelease(gradient);
    }
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
}

- (void)drawText:(CGContextRef)context withRect:(CGRect)rect {
    if (_indicatorTextLabel == nil) {
        return;
    }
    
    CGRect innerRect          = CGRectInset(rect, 4, 2);
    _indicatorTextLabel.frame = innerRect;
    
    NSString *indicatorText = _indicatorTextLabel.text;
    BOOL hasText            = (_indicatorTextLabel.text != nil);
    
    if (!hasText) {
        indicatorText = [NSString stringWithFormat:@"%.0f%%", (self.progress * 100)];
    }
    
    CGRect textRect = CGRectZero;
    if ([indicatorText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textRect = [indicatorText boundingRectWithSize:CGRectInset(innerRect, 20, 0).size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName: _indicatorTextLabel.font }
                                               context:nil];
    }
    
    if (innerRect.size.width < textRect.size.width || innerRect.size.height + 4 < textRect.size.height) {
        return;
    }
    
    _indicatorTextLabel.text = indicatorText;
    
    BOOL hasTextColor = ![_indicatorTextLabel.textColor isEqual:[UIColor clearColor]];
    
    if (!hasTextColor) {
        CGColorRef backgroundColor = nil;
        
        if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeFixCenter) {
            backgroundColor = _trackTintColor.CGColor ?: [UIColor blackColor].CGColor;
        } else {
            backgroundColor = (__bridge CGColorRef)[_colors lastObject];
        }
        
        const CGFloat *components = CGColorGetComponents(backgroundColor);
        BOOL isLightBackground    = (components[0] + components[1] + components[2]) / 3.0f >= 0.5f;
        
        _indicatorTextLabel.textColor = (isLightBackground) ? [UIColor blackColor] : [UIColor whiteColor];
    }
    
    [_indicatorTextLabel drawTextInRect:innerRect];
    
    if (!hasTextColor) {
        _indicatorTextLabel.textColor = [UIColor clearColor];
    }
    if (!hasText) {
        _indicatorTextLabel.text = nil;
    }
}

#pragma mark - KVO Delegate Methods

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//  if ([keyPath isEqualToString:@"hideStripes"] || [keyPath isEqualToString:@"stripesAnimated"])
//  {
//    [self updateStripesTimer];
//  }
//}

@end
