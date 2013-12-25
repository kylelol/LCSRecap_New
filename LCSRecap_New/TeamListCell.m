//
//  TeamListCell.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 12/24/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamListCell.h"

@implementation TeamListCell
{
    UIActivityIndicatorView *indicator;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)awakeFromNib
{
    indicator = [[UIActivityIndicatorView alloc] init];
    indicator.center = self.teamImageView.center;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [indicator startAnimating];
    [self.teamImageView addSubview:indicator];
    [self.teamImageView bringSubviewToFront:indicator];
    
    [self.teamImageView addObserver:self forKeyPath:@"image" options:0 context:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [self.teamImageView removeObserver:self forKeyPath:@"image"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"])
    {
        [indicator stopAnimating];
    }
}


@end
