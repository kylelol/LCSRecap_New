//
//  SeasonModel.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/18/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "SeasonModel.h"

@implementation SeasonModel

@dynamic name;
@dynamic key;
@dynamic events;
@dynamic eventKeys;
@dynamic eventWeekDictionary;

+(NSString *)parseClassName
{
    return @"LCSSeasons";
}

-(NSString *)getEventNameAtIndex:(int)index
{
    if ([self.events count] != 0 && index <= [self.events count])
    {
        return (NSString*)self.events[index];
    }
    
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"season-name"];
    [aCoder encodeObject:self.key forKey:@"season-key"];
    [aCoder encodeObject:self.events forKey:@"season-events"];
    [aCoder encodeObject:self.eventKeys forKey:@"season-keys"];
    [aCoder encodeObject:self.eventWeekDictionary forKey:@"event-week"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"season-name"];
        self.key = [aDecoder decodeObjectForKey:@"season-key"];
        self.events = [aDecoder decodeObjectForKey:@"season-events"];
        self.eventKeys = [aDecoder decodeObjectForKey:@"season-keys"];
        self.eventWeekDictionary = [aDecoder decodeObjectForKey:@"event-week"];
    }
    return self;
}

@end
