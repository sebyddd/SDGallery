//
//  SDGalleryCell.m
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import "SDGalleryCell.h"
#import "SDGallery.h"
#define isLandscape UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

@implementation SDGalleryCell

static const CGFloat SDMotionViewRotationMinimumTreshold = 0.1f;
static const CGFloat SDMotionGyroUpdateInterval = 1 / 100;
static const CGFloat SDMotionViewRotationFactor = 4.0f;

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 4;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.bouncesZoom = NO;
        _scrollView.contentSize = CGSizeMake(900, frame.size.height);
        _scrollView.scrollEnabled = NO;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 900, frame.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_scrollView];
        [_scrollView addSubview:_imageView];
        
        singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapGestureRecognizer.numberOfTapsRequired = 1;
        singleTapGestureRecognizer.cancelsTouchesInView = YES;
        [_scrollView addGestureRecognizer:singleTapGestureRecognizer];

        _motionRate = _imageView.frame.size.width / frame.size.width * SDMotionViewRotationFactor;
        _minimumXOffset = 0;
        _maximumXOffset = _scrollView.contentSize.width - _scrollView.frame.size.width;
        _stopTracking = NO;
        [self startMonitoring];
    }
    
    return self;
}

-(void)setImage:(UIImage *)image {
    
    self.imageView.image = image;
    float newWidth = self.frame.size.height * image.size.width / image.size.height;
    [_imageView setFrame:CGRectMake(0, 0, newWidth, self.frame.size.height)];
    [_scrollView setContentSize:CGSizeMake(newWidth, self.frame.size.height)];
    _maximumXOffset = _scrollView.contentSize.width - _scrollView.frame.size.width;
    
    // Center image
    [_scrollView setContentOffset:CGPointMake((_scrollView.contentSize.width/2) - (_scrollView.bounds.size.width/2), 0)];
}

#pragma mark - UIScrollView Delegates

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [[scrollView subviews] firstObject];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    [self stopMonitoring];
    
    if (scrollView.zoomScale < 1.0f)
        [scrollView setZoomScale:1.0];
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {

    if (scale != 1)
        [self.scrollView zoomToRect:self.scrollView.bounds animated:YES];
    
    [self startMonitoring];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale)
        [[self getViewController] dismissGalleryToSource];
    else
        // Zoom out
        [self.scrollView zoomToRect:self.scrollView.bounds animated:YES];
    
}

- (SDGallery *)getViewController {
    
    id vc = [self nextResponder];
    while(![vc isKindOfClass:[SDGallery class]] && vc!=nil)
        vc = [vc nextResponder];
    
    return vc;
}

#pragma mark - Core Motion

- (void)startMonitoring {
    
    if (!motionManager) {
        motionManager = [[CMMotionManager alloc] init];
        motionManager.gyroUpdateInterval = SDMotionGyroUpdateInterval;
    }
    
    if (![motionManager isGyroActive] && [motionManager isGyroAvailable] )
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        
                                        CGFloat rotationRate = isLandscape ? gyroData.rotationRate.x : gyroData.rotationRate.y;
                                        if (fabs(rotationRate) >= SDMotionViewRotationMinimumTreshold) {
                                            CGFloat offsetX = _scrollView.contentOffset.x - rotationRate * _motionRate;
                                            if (offsetX > _maximumXOffset)
                                                offsetX = _maximumXOffset;
                                            else if (offsetX < _minimumXOffset)
                                                offsetX = _minimumXOffset;
                                            
                                            if (!self.stopTracking)
                                                [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut animations:^{
                                                    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
                                                }completion:nil];
                                        }
                                    }];
    else
        NSLog(@"There is no available gyroscope.");
    
}

- (void)stopMonitoring {
    [motionManager stopGyroUpdates];
}

@end
