//
//  TeamProfileHeadView.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/2/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import "TeamProfileHeadView.h"

@implementation TeamProfileHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.frame = CGRectMake(0, 0, 320, 300);
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
