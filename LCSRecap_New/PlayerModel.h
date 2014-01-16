//
//  PlayerModel.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/3/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import <Parse/Parse.h>

@interface PlayerModel : PFObject <PFSubclassing, NSCoding>

+(NSString*)parseClassName;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *season;
@property (nonatomic, strong) NSString *teamKey;
@property (nonatomic, strong) NSString *lane;
@property (nonatomic, strong) NSString *profileImage;
@property (nonatomic, strong) NSString *fullName;




@end
