//
//  EventWeekModel.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 1/9/14.
//  Copyright (c) 2014 Kyle Kirkland. All rights reserved.
//

#import <Parse/Parse.h>

@interface EventWeekModel : PFObject <PFSubclassing, NSCoding>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *event;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *season;

@end
