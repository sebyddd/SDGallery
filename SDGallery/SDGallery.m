//
//  SDGallery.m
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import "SDGallery.h"
#import "SDGalleryCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SDGallery

- (id)initWithImages:(NSArray *)images {
    if (self = [super init]) {
        _images = images;
    }
    return self;
}

- (id)initWithImagesURLs:(NSArray *)imagesURLs {
    if (self = [super init]) {
        _images = imagesURLs;
        usingImageURLs = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0.0f;
    layout.minimumLineSpacing = 0.0f;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[SDGalleryCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UICollectionView Delegate & DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _images.count;
}

-(SDGalleryCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SDGalleryCell *cell = (SDGalleryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell)
        cell = [[SDGalleryCell alloc] initWithFrame:collectionView.frame];
    
    if (usingImageURLs)
        [cell.imageView sd_setImageWithURL:_images[indexPath.row] placeholderImage:[UIImage imageNamed:@"1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }];
    else
        [cell setImage:_images[indexPath.row]];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

-(void)dismissGalleryToSource {
    
    CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
    SDGalleryCell *cell = (SDGalleryCell*)[self.collectionView cellForItemAtIndexPath:visibleIndexPath];
    
    self.currentlyVisibleImage = cell.imageView;
    self.currentlyVisibleScrollView = cell.scrollView;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
