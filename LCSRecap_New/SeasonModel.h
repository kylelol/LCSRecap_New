//
//  SeasonModel.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/18/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Parse/Parse.h>
#import <Parse/PFObject+Subclass.h>
#import "LCSModel.h"

@interface SeasonModel : PFObject <PFSubclassing, LCSModel, NSCoding>

+(NSString*)parseClassName;

-(NSString *)getEventNameAtIndex:(int)index;

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) NSArray *eventKeys;
@property (nonatomic, strong) NSDictionary *eventWeekDictionary;

@end
