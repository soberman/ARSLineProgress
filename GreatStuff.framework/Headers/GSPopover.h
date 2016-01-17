//
//  ARSPopover.h
//  Popover
//
//  Created by Yaroslav Arsenkin on 27.05.15.
//  Copyright (c) 2015 Iaroslav Arsenkin. All rights reserved.
//  Website: http://arsenkin.com
//

#import <UIKit/UIKit.h>


@protocol GSPopoverDelegate <NSObject>

@optional

/*!
 Popover notifies the delegate, that the popover needs to reposition it's location.
 */
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing *)view;

/*!
 Popover asks the delegate, whether it should dismiss itself.
 */
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController;

/*!
 Popover notifies the delegate, that popover did dismiss itself.
 */
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController;

@end


@interface GSPopover : UIViewController

/// Popover's delegate.
@property (nonatomic, weak) id<GSPopoverDelegate> delegate;

/// Use this property to configure where popover's arrow should be pointing.
@property (nonatomic, assign) UIPopoverArrowDirection arrowDirection;

/// The view containing the anchor rectangle for the popover.
@property (nonatomic, weak) UIView *sourceView;

/// The rectangle in the specified view in which to anchor the popover.
@property (nonatomic, assign) CGRect sourceRect;

/// The preferred size for the popover’s view.
@property (nonatomic, assign) CGSize contentSize;

/// The color of the popover’s backdrop view.
@property (nonatomic, strong) UIColor *backgroundColor;

/// An array of views that the user can interact with while the popover is visible.
@property (nonatomic, strong) NSArray *passthroughViews;

///The margins that define the portion of the screen in which it is permissible to display the popover.
@property (nonatomic, assign) UIEdgeInsets popoverLayoutMargins;

/*!
 Use this method to put your custom views into popover.
 @param content Use this block to supply your custom elements, that will be shown inside popover element.
 @param popover Reference to GSPopover, so you could add element to it's subview.
 @param popoverPresentedSize Popover's size after it is being presented.
 @param popoverArrowHeight Height of the arrow.
 
 @warning Be sure to call insertContentIntoPopover: only after you have presented it, otherwise popoverPresentationSize frame might be of wrong size.
 
 @code
 [popoverController insertContentIntoPopover:^(GSPopover *popover) {
 UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
 [button setTitle:@"Works?" forState:UIControlStateNormal];
 [button sizeToFit];
 [button setCenter:CGPointMake(50, 25)];
 [button addTarget:popover
 action:@selector(closePopover)
 forControlEvents:UIControlEventTouchUpInside];
 
 [popover.view addSubview:button];
 }];
 @endcode
 
 */
- (void)insertContentIntoPopover:(void (^)(GSPopover *popover, CGSize popoverPresentedSize, CGFloat popoverArrowHeight))content;

/*!
 Helpers method, invoking wich will close the popover.
 */
- (void)closePopover;

@end
