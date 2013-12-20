//
//  ParseDatabaseUtility.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "ParseDatabaseUtility.h"
#import <Parse/Parse.h>
#import "SeasonModel.h"

@implementation ParseDatabaseUtility

-(void)requestAllSeasonsForRegion:(NSString *)region withCompletion:(SeasonRetrievedFromParseCompletionBlock)completionBlock
{
    PFQuery *query = [SeasonModel query];
    [query whereKey:@"region" equalTo:region];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (completionBlock)
        {
            completionBlock(YES, error, objects);
        }
    }];
    
}

@end
