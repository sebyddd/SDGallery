//
//  SDGalleryCell.m
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import "SDGalleryCell.h"

@implementation SDGalleryCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 4;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_scrollView];
        [_scrollView addSubview:_imageView];
        
        singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapGestureRecognizer.numberOfTapsRequired = 1;
        singleTapGestureRecognizer.cancelsTouchesInView = YES;
        [_scrollView addGestureRecognizer:singleTapGestureRecognizer];
        
        doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        doubleTapGestureRecognizer.cancelsTouchesInView = YES;
        [_scrollView addGestureRecognizer:doubleTapGestureRecognizer];
        [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
        
    }
    
    return self;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [[scrollView subviews] firstObject];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale)
        //        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"dismiss");
    else
        // Zoom out
        [self.scrollView zoomToRect:self.scrollView.bounds animated:YES];
    
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        // Zoom in
        CGPoint center = [tapGestureRecognizer locationInView:self.scrollView];
        CGSize size = CGSizeMake(self.scrollView.bounds.size.width / self.scrollView.maximumZoomScale,
                                 self.scrollView.bounds.size.height / self.scrollView.maximumZoomScale);
        CGRect rect = CGRectMake(center.x - (size.width / 2.0), center.y - (size.height / 2.0), size.width, size.height);
        [self.scrollView zoomToRect:rect animated:YES];
    }
    else {
        // Zoom out
        [self.scrollView zoomToRect:self.scrollView.bounds animated:YES];
    }
}

@end
