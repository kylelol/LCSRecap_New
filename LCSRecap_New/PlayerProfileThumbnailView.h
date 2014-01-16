//
//  PlayerProfileThumbnailView.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/3/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerProfileThumbnailView : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *playerLaneLabel;
@property (nonatomic, weak) IBOutlet UIImageView *playerPictureImageView;

@property (nonatomic, weak) IBOutlet UILabel *playerNameLabel;

@end
