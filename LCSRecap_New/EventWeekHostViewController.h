//
//  EventWeekHostViewController.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/9/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import "ViewPagerController.h"

@class SeasonModel;

@interface EventWeekHostViewController : ViewPagerController

@property (nonatomic, strong) SeasonModel *currentSeason;
@property (nonatomic, assign) NSInteger eventIndex;

@end
