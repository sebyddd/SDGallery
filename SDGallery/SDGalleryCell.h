//
//  SDGalleryCell.h
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreMotion;

@interface SDGalleryCell : UICollectionViewCell <UIScrollViewDelegate> {
    UITapGestureRecognizer *singleTapGestureRecognizer;
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@property (nonatomic, assign) CGFloat motionRate;
@property (nonatomic, assign) NSInteger minimumXOffset;
@property (nonatomic, assign) NSInteger maximumXOffset;
@property (nonatomic, assign) BOOL stopTracking;

-(void)setImage:(UIImage *)image;

@end
