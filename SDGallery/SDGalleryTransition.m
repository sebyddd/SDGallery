//
//  SDGalleryTransition.m
//  SDGallery
//
//  Created by Sebastian Dobrincu on 28/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import "SDGalleryTransition.h"
#import "SDGallery.h"

@implementation SDGalleryTransition

- (id)initWithReferenceImageView:(UIImageView *)referenceImageView {
    if (self = [super init]) {
        NSAssert(referenceImageView.contentMode == UIViewContentModeScaleAspectFill, @"*** referenceImageView must have a UIViewContentModeScaleAspectFill contentMode!");
        _referenceImageView = referenceImageView;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *viewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    return viewController.isBeingPresented ? 0.5 : 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *viewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (viewController.isBeingPresented)
        [self animateZoomInTransition:transitionContext];
    else
        [self animateZoomOutTransition:transitionContext];
    
}

- (void)animateZoomInTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Get the view controllers participating in the transition
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SDGallery *toViewController = (SDGallery *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSAssert([toViewController isKindOfClass:SDGallery.class], @"*** toViewController must be a SDGallery!");
    
    UIImageView *transitionView = [[UIImageView alloc] initWithImage:self.referenceImageView.image];
    transitionView.contentMode = UIViewContentModeScaleAspectFill;
    transitionView.clipsToBounds = YES;
    transitionView.frame = [transitionContext.containerView convertRect:self.referenceImageView.bounds fromView:self.referenceImageView];
    [transitionContext.containerView addSubview:transitionView];
    CGRect transitionViewFinalFrame = CGRectMake(0, 0, [transitionContext finalFrameForViewController:toViewController].size.width, [transitionContext finalFrameForViewController:toViewController].size.height);
    self.referenceImageView.alpha = 0;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromViewController.view.alpha = 0;
                         transitionView.frame = transitionViewFinalFrame;
                     } completion:^(BOOL finished) {
                         
                         fromViewController.view.alpha = 1;
                         [transitionView removeFromSuperview];
                         [transitionContext.containerView addSubview:toViewController.view];
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)animateZoomOutTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // Get the view controllers participating in the transition
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    SDGallery *fromViewController = (SDGallery *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NSAssert([fromViewController isKindOfClass:SDGallery.class], @"*** fromViewController must be a SDGallery!");
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    [transitionContext.containerView addSubview:toViewController.view];
    [transitionContext.containerView sendSubviewToBack:toViewController.view];
    CGRect transitionViewFinalFrame = fromViewController.sourceFrame;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         toViewController.view.alpha = 1;
                         [fromViewController.currentlyVisibleScrollView setFrame:transitionViewFinalFrame];
                         [fromViewController.currentlyVisibleImage setFrame:CGRectMake(0, 0, transitionViewFinalFrame.size.width, transitionViewFinalFrame.size.height)];
                         [fromViewController.currentlyVisibleScrollView setContentOffset:CGPointZero];
                         self.referenceImageView.alpha = 1;
                         
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
