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

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *images = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"]];
        SDGallery *viewController = [[SDGallery alloc] initWithImages:images];
        [self presentViewController:viewController animated:YES completion:nil];
        
    });
    
}

@end
