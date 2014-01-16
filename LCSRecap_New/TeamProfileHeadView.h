//
//  TeamProfileHeadView.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/2/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamProfileHeadView : UIScrollView

@property (nonatomic, weak) IBOutlet UIImageView *teamLogoImageView;
@property (nonatomic, weak) IBOutlet UIImageView *teamProfileImageView;
@property (nonatomic, weak) IBOutlet UILabel *winLossLabel;
@property (nonatomic, weak) IBOutlet UILabel *regionLabel;
@property (nonatomic, weak) IBOutlet UITextView *bioTextView;

@end
