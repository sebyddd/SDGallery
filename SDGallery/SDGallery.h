//
//  SDGallery.h
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDGallery : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

- (id)initWithImages:(NSArray *)images;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *images;

@end
