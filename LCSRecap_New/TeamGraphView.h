//
//  TeamGraphView.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/6/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TeamGraphViewDelegate;

@interface TeamGraphView : UIView

@property (nonatomic, strong) id<TeamGraphViewDelegate> delegate;

@end

@protocol TeamGraphViewDelegate <NSObject>

-(void)didSwitchSegment:(NSInteger)selectedSegment;

@end