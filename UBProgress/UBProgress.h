//
//  UBProgress.h
//  UBProgress
//
//  Created by Paulo Uchôa on 20/07/21.
//


#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// The progress bar appearance.

typedef NS_ENUM (NSUInteger, UBProgressBarType) {

    // The progress bar has rounded corners.

    UBProgressBarTypeRounded = 0,

    // The progress bar has squared corners.

    //  UBProgressBarTypeFlat    = 1,
};

// The display mode of the indicator text.
typedef NS_ENUM (NSUInteger, UBProgressBarIndicatorTextDisplayMode) {

    // The indicator text is not displayed.
    UBProgressBarIndicatorTextDisplayModeNone     = 0,

    // The indicator text is displayed over the track bar and below the progress bar.
    UBProgressBarIndicatorTextDisplayModeFixedCenter    = 1,

    // The indicator text is diplayed over the progress bar.
    UBProgressBarIndicatorTextDisplayModeProgressRight = 2,
    
    //
    UBProgressBarIndicatorTextDisplayModeProgressCenter = 3,

    // The indicator text is displayed over the track bar and over the progress bar in the right.
    UBProgressBarIndicatorTextDisplayModeFixedRight = 4
};


IB_DESIGNABLE @interface UBProgress : UIView

#pragma mark Managing the Progress Bar
/** @name Managing the Progress Bar */

/**
 * @abstract The current progress shown by the receiver.
 * @discussion The current progress is represented by a floating-point value
 * between 0.0 and 1.0, inclusive, where 1.0 indicates the completion of the
 * task.
 *
 * The default value is 0.3. Values less than 0.0 and greater than 1.0 are
 * pinned to those limits.
 */
@property (atomic, assign) IBInspectable CGFloat progress;

/**
 * @abstract Adjusts the current progress shown by the receiver, optionally
 * animating the change.
 * @param progress The new progress value.
 * @param animated YES if the change should be animated, NO if the change should
 * happen immediately.
 * @discussion The current progress is represented by a floating-point value
 * between 0.0 and 1.0, inclusive, where 1.0 indicates the completion of the
 * task.
 * The default value is 0.0. Values less than 0.0 and greater than 1.0 are
 * pinned to those limits.
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

- (void)setTypeText:(UBProgressBarIndicatorTextDisplayMode)type;

- (void)setFont:(UIFont*_Nonnull)font;

#pragma mark Configuring the Progress Bar
/** @name Configuring the Progress Bar */
/**
 * @abstract The colors shown for the portion of the progress bar
 * that is filled.
 * @discussion All the colors in the array are drawn as a gradient
 * visual of equal size.
 */
@property (nonatomic, strong, nonnull) NSArray *progressTintColors; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract The color shown for the portion of the progress bar that is filled.
 */
@property (nonatomic, strong, nonnull) IBInspectable UIColor *progressTintColor; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract The color shown for the portion of the progress bar that is not
 * filled.
 */
@property (nonatomic, strong, nonnull) IBInspectable UIColor *trackTintColor; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract A CGFloat value that determines the inset between the track and the
 * progressBar for the rounded progress bar type.
 * @discussion The default value is 1px.
 */
@property (nonatomic, assign) IBInspectable CGFloat progressBarInset; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract The type of the progress bar.
 * @discussion The default value is set to `YLProgressBarTypeRounded`. The corner
 * radius can be configured through the `cornerRadius` property.
 */
@property (nonatomic, assign) IBInspectable UBProgressBarType type; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract The corner radius of the progress bar.
 * @discussion The default value is 0. It means that the corner radius is equal
 * to the half of the height.
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius; //UI_APPEARANCE_SELECTOR;

#pragma mark Displaying Text
/** @name Displaying Text */

/**
 * @abstract A label to display some indications for the user.
 * When the label text is set to nil it shows the progress value as a percentage
 * You can configure its font color, the font size, the text alignement, etc. as
 * any other labels.
 * @discussion By default the label text is set to nil and its text color change
 * using the background color.
 */
@property (nonatomic, strong, nonnull) UILabel *indicatorTextLabel;

/**
 * @abstract The display indicator text mode. It defines where the indicator
 * text needs to display.
 * @discussion The default value is set to
 * `YLProgressBarIndicatorTextDisplayModeNone`.
 */
@property (nonatomic, assign) IBInspectable UBProgressBarIndicatorTextDisplayMode indicatorTextDisplayMode; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract A Boolean value that determines whether the track is hidden.
 * @discussion Setting the value of this property to YES hides the track and
 * setting it to NO shows the track. The default value is NO.
 */
@property (nonatomic, assign) IBInspectable BOOL hideTrack;

@end

//! Project version number for YLProgressBar.
FOUNDATION_EXPORT double UBProgressVersionNumber;

//! Project version string for YLProgressBar.
FOUNDATION_EXPORT const unsigned char UBProgressVersionString[];

#import <UBProgress/UBProgress.h>
