//
//  PlayerProfileThumbnailView.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/3/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import "PlayerProfileThumbnailView.h"
@interface PlayerProfileThumbnailView ()
{
    UIActivityIndicatorView *indicator;
}
@end

@implementation PlayerProfileThumbnailView

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
    indicator = [[UIActivityIndicatorView alloc] init];
    indicator.center = self.center;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [indicator startAnimating];
    [self addSubview:indicator];
    
    [self.playerPictureImageView addObserver:self forKeyPath:@"image" options:0 context:nil];
    
}

-(void)dealloc
{
    [self.playerPictureImageView removeObserver:self forKeyPath:@"image"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"])
    {
        [indicator stopAnimating];
    }
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
