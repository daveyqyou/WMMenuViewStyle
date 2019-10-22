//
//  ViewController.m
//  WMMenuViewStyle
//
//  Created by DaveYou on 2019/10/22.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "ViewController.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "WMPageController.h"
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

// 状态栏高度
#define kStatusBarHeight        ([[UIApplication sharedApplication] statusBarFrame].size.height)
// 导航栏高度
#define kNavBarHeight           (kStatusBarHeight + 44)

// 判断是否是iPhone X
#define kIsIphoneX              (kStatusBarHeight>20?YES:NO)
// 标签栏高度
#define kBottomHeight           (kIsIphoneX ? 34 :0)


#import "ContentViewController.h"

@interface ViewController () <WMPageControllerDelegate, WMPageControllerDataSource>
@property (nonatomic, strong) WMPageController *pageController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"WMPageController";
    [self setupSubViews];
}
- (void)setupSubViews{
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    self.pageController.menuItemWidth = kScreen_Width/3.0;
    self.pageController.menuViewStyle = WMMenuViewStyleStrokeImage;
    self.pageController.pageAnimatable = YES;
    self.pageController.titleColorNormal = [UIColor darkGrayColor];
    self.pageController.titleColorSelected = [UIColor whiteColor];
    self.pageController.titleSizeNormal = 14;
    self.pageController.titleSizeSelected = 15;
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 4;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [[ContentViewController alloc]initWithIndex:index];
}
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    NSArray *titleString = @[@"互动消息", @"其他提醒",@"我的文章", @"我的收藏"];
    return titleString[index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0, kNavBarHeight, kScreen_Width, 41);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return CGRectMake(0,  kNavBarHeight + 41, kScreen_Width, kScreen_Height-41-kNavBarHeight-kBottomHeight);
}
#pragma mark - lazy loading
- (WMPageController *)pageController {
    if (_pageController == nil) {
        _pageController = [[WMPageController alloc]init];
    }
    return _pageController;
}

@end
