//
//  TeamGraphView.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/6/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import "TeamGraphView.h"

@implementation TeamGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)didSelectSegment:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    [self.delegate didSwitchSegment:selectedSegment];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
