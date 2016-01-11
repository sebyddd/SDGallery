//
//  SDGallery.h
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDGalleryTransition.h"

@interface SDGallery : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource> {
    BOOL usingImageURLs;
}

- (id)initWithImages:(NSArray *)images;
- (id)initWithImagesURLs:(NSArray *)imagesURLs;

@property (strong, nonatomic) UIImageView *currentlyVisibleImage;
@property (strong, nonatomic) UIScrollView *currentlyVisibleScrollView;
@property (nonatomic) UIImage *senderScreenshot;

@property (nonatomic) CGRect sourceFrame;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *images;

-(void)dismissGalleryToSource;

@end
