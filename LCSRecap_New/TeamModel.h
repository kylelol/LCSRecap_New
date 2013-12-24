//
//  TeamModel.h
//  LCSRecap_New
//
//  Created by Kyle Kirkland on 12/20/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Parse/Parse.h>
#import "LCSModel.h"

@interface TeamModel : PFObject <PFSubclassing,LCSModel, NSCoding>

+(NSString*)parseClassName;

@property (nonatomic, strong) NSString* season;
@property (nonatomic, strong) NSString* teamName;
@property (nonatomic, strong) NSString *region;

@end
