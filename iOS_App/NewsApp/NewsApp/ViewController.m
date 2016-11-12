//
//  ViewController.m
//  NewsApp
//
//  Created by Mohamed Haseel on 12/11/16.
//  Copyright © 2016 Reflections. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
    
    UIImageView *imageView = [cell viewWithTag:999];
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"news%d.png", (int)indexPath.row + 1]]];
    
    return cell;
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"newsDetail"]  animated:YES completion:nil];
    }
}

@end
