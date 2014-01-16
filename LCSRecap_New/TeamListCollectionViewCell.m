//
//  TeamListCollectionViewCell.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 12/30/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamListCollectionViewCell.h"
#import "TeamListCollectionViewCellSelectionView.h"
#import <QuartzCore/QuartzCore.h>

@interface TeamListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *imageBackgroundView;



@end

@implementation TeamListCollectionViewCell

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
    //self.teamImageView.layer.cornerRadius = 15;
    //self.imageBackgroundView.layer.cornerRadius = self.imageBackgroundView.frame.size.height;
    //self.teamImageView.clipsToBounds = YES;
    TeamListCollectionViewCellSelectionView *view = [[TeamListCollectionViewCellSelectionView alloc] initWithFrame:CGRectZero];
    self.selectedBackgroundView = view;
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
