//
//  SDGallery.m
//  SDGallery
//
//  Created by Sebastian Dobrincu on 27/12/15.
//  Copyright © 2015 Sebastian Dobrincu. All rights reserved.
//

#import "SDGallery.h"
#import "SDGalleryCell.h"

@interface SDGallery ()


@end

@implementation SDGallery

- (id)initWithImages:(NSArray *)images {
    if (self = [super init]) {
        _images = images;
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
    self.collectionView.backgroundColor = [UIColor orangeColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[SDGalleryCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView Delegate & DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _images.count;
}

-(SDGalleryCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SDGalleryCell *cell = (SDGalleryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell)
        cell = [[SDGalleryCell alloc] initWithFrame:collectionView.frame];
    
    cell.imageView.image = _images[indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

@end
