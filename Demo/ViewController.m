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
    
    SDGallery *viewController = [[SDGallery alloc] initWithImagesURLs:@[@"https://placehold.it/900x600", @"https://placehold.it/500x700", @"https://images.unsplash.com/photo-1433769778268-24b797c4fc9a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=dd0a3dd2d153be0f28c6daa72cfb002c"]];
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
