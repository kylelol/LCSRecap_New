//
//  EventWeekModel.m
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/9/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import "EventWeekModel.h"
#import <Parse/PFObject+Subclass.h>

@implementation EventWeekModel

@dynamic event;
@dynamic url;
@dynamic season;
@dynamic week;

+(NSString *)parseClassName
{
    return @"LCSEventWeek";
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if ( self )
    {
        self.event = [aDecoder decodeObjectForKey:@"event"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.season = [aDecoder decodeObjectForKey:@"season"];
        self.week = [aDecoder decodeObjectForKey:@"week"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.event forKey:@"event"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.season forKey:@"season"];
    [aCoder encodeObject:self.week forKey:@"week"];
}

@end
