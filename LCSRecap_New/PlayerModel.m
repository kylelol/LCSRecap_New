//
//  PlayerModel.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/3/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import "PlayerModel.h"
#import <Parse/PFObject+Subclass.h>

@implementation PlayerModel

@dynamic name;
@dynamic fullName;
@dynamic profileImage;
@dynamic season;
@dynamic lane;
@dynamic teamKey;

+(NSString *)parseClassName
{
    return @"LCSPlayers";
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.fullName = [aDecoder decodeObjectForKey:@"fullName"];
        self.profileImage = [aDecoder decodeObjectForKey:@"profileImage"];
        self.season = [aDecoder decodeObjectForKey:@"season"];
        self.lane = [aDecoder decodeObjectForKey:@"lane"];
        self.teamKey = [aDecoder decodeObjectForKey:@"teamKey"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.fullName forKey:@"fullName"];
    [aCoder encodeObject:self.profileImage forKey:@"profileImage"];
    [aCoder encodeObject:self.season forKey:@"season"];
    [aCoder encodeObject:self.lane forKey:@"lane"];
    [aCoder encodeObject:self.teamKey forKey:@"teamKey"];
}

@end
