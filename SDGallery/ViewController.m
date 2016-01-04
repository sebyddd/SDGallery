//
//  ViewController.m
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import "ViewController.h"
#import "SDGallery.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    NSArray *images = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"]];
    SDGallery *viewController = [[SDGallery alloc] initWithImages:images];
    viewController.sourceFrame = _imageView.frame;
    viewController.transitioningDelegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if ([presented isKindOfClass:SDGallery.class])
        return [[SDGalleryTransition alloc] initWithReferenceImageView:_imageView];
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if ([dismissed isKindOfClass:SDGallery.class])
        return [[SDGalleryTransition alloc] initWithReferenceImageView:_imageView];
    return nil;
}

@end
