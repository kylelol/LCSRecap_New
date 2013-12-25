//
//  TeamModel.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 12/20/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "TeamModel.h"
#import <Parse/PFObject+Subclass.h>

@implementation TeamModel

@dynamic name;
@dynamic key;
@dynamic season;
@dynamic teamName;
@dynamic region;
@dynamic logoUrl;

+(NSString *)parseClassName
{
    return @"LCSTeams";
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.key forKey:@"season-key"];
    [aCoder encodeObject:self.season forKey:@"season-name"];
    [aCoder encodeObject:self.teamName forKey:@"team-name"];
    [aCoder encodeObject:self.region forKey:@"region-name"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.key = [aDecoder decodeObjectForKey:@"season-key"];
        self.season = [aDecoder decodeObjectForKey:@"season-name"];
        self.teamName = [aDecoder decodeObjectForKey:@"team-name"];
        self.region = [aDecoder decodeObjectForKey:@"region-name"];

    }
    return self;
}

@end
