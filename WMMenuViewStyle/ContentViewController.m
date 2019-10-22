//
//  ContentViewController.m
//  WMMenuViewStyle
//
//  Created by DaveYou on 2019/10/22.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (nonatomic, assign) NSInteger index;
@end

@implementation ContentViewController

- (instancetype)initWithIndex:(NSInteger)index {
    if (self = [super init]) {
        _index = index;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"---%ld", self.index);
    self.view.backgroundColor = [self randomColor];
}

- (UIColor *)randomColor {
    
    CGFloat r = arc4random() % 256 / 255.0;
    CGFloat g = arc4random() % 256 / 255.0;
    CGFloat b = arc4random() % 256 / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
