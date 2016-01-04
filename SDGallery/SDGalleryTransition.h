//
//  SDGalleryTransition.h
//  SDGallery
//
//  Created by Sebastian Dobrincu on 28/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SDGalleryTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic, readonly) UIImageView *referenceImageView;
- (id)initWithReferenceImageView:(UIImageView *)referenceImageView;

@end
