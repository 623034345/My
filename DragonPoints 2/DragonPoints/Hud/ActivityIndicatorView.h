//
//  ActivityIndicatorView.h
//
//  Created by Mounir Ybanez on 4/24/14.
//

#import <UIKit/UIKit.h>

@protocol ActivityIndicatorViewDelegate;

@interface ActivityIndicatorView : UIView

/** The number of circle indicators. */
@property (readwrite, nonatomic) NSUInteger numberOfCircles;

/** The spacing between circles. */
@property (readwrite, nonatomic) CGFloat internalSpacing;

/** The radius of each circle. */
@property (readwrite, nonatomic) CGFloat radius;

/** The base animation delay of each circle. */
@property (readwrite, nonatomic) CGFloat delay;

/** The base animation duration of each circle*/
@property (readwrite, nonatomic) CGFloat duration;

/**
 Starts the animation of the activity indicator.
 */
- (void)startAnimating;

/**
 Stops the animation of the acitivity indciator.
 */
- (void)stopAnimating;

@end

