//
//  TeamProfileViewController.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/3/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeamModel;

@interface TeamProfileViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) TeamModel *team;

@end
