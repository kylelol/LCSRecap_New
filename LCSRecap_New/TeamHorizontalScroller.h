//
//  HorizontalScroller.h
//  BlueLibrary
//
//  Created by Kyle Kirkland on 12/17/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TeamHorizontalScrollerDelegate;

@interface TeamHorizontalScroller : UIView

@property (weak) id<TeamHorizontalScrollerDelegate> delegate;

-(void)reload;

@end

@protocol TeamHorizontalScrollerDelegate <NSObject>

@required
-(NSInteger)numberOfViewsForHorizontalScroller:(TeamHorizontalScroller*)scroller;

-(UIView *)horizontalScroller:(TeamHorizontalScroller*)scroller viewAtIndex:(int)index;

-(void)horizontalScroller:(TeamHorizontalScroller*)scroller clickedViewAtIndex:(int)index;

@optional
-(NSInteger)initialViewIndexForHorizontalScroller:(TeamHorizontalScroller*)scroller;
@end
