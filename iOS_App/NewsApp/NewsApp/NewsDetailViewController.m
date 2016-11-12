//
//  NewsDetailViewController.m
//  NewsApp
//
//  Created by Mohamed Haseel on 12/11/16.
//  Copyright © 2016 Reflections. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController () {
    __weak IBOutlet UIScrollView *scrollView;
}

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scrollView.contentSize = CGSizeMake(320, 1500);
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
