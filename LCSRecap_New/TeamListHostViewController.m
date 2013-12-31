//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "TeamListHostViewController.h"
#import "TeamsListViewController.h"
#import "RESideMenu.h"
#import "LCSRecapUtilities.h"

@interface TeamListHostViewController () <ViewPagerDataSource, ViewPagerDelegate>

@property (nonatomic, strong) NSArray *teamsArray;

@end

@implementation TeamListHostViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataSource = self;
    self.delegate = self;
    
    self.title = @"Teams";
    
    // Keeps tab bar below navigation bar on iOS 7.0+
    // if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    //     self.edgesForExtendedLayout = UIRectEdgeNone;
    // }
    
    
    self.navigationItem.leftBarButtonItem = ({
        
        UIBarButtonItem *button;
        button = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(didPressMenuButton:)];
        
        button;
    });
    
    [[LCSRecapUtilities sharedUtilities] getAllTeamsForRegion:@"NA" withCompletion:^(BOOL success, NSError *error, NSArray *teams) {
        
        self.teamsArray = teams;
        [self reloadData];
    }];
    
    //self.teams = [[TeamsArrayModel alloc] initWithRegion:@"NA" forSeason:@"s3"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needToReloadData:) name:@"TeamsDidFinishLoading" object:nil];
    
}

-(void)didPressMenuButton:(id)sender
{
    [self.sideMenuViewController presentMenuViewController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectTabWithNumberFive {
    [self selectTabAtIndex:5];
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    if (self.teamsArray)
        return self.teamsArray.count;
    return 2;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [[LCSRecapUtilities sharedUtilities] getSeasonTitleForRegion:@"NA" atIndex:index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    TeamsListViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"teamContentViewController"];
    
    cvc.teamsDictionaryArray = ((NSArray*)[self.teamsArray objectAtIndex:index]);
    
    // cvc.labelString = [NSString stringWithFormat:@"Content View #%i", index];
    
    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 0.0;
        case ViewPagerOptionTabHeight:
            return 49.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [UIColor colorWithRed:0.9372549f green:0.9372549f blue:0.95686275f alpha:1.0];
        default:
            return color;
    }
}

@end
