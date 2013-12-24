//
//  ParseDatabaseUtility.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SeasonRetrievedFromParseCompletionBlock)(BOOL success, NSError *error, NSArray *seasons);
typedef void (^TeamsRetrievedFromParseCompletionBlock)(BOOL success, NSError *error, NSArray *teams);

@class SeasonModel;

@interface ParseDatabaseUtility : NSObject

-(void)requestAllSeasonsForRegion:(NSString*)region
                   withCompletion:(SeasonRetrievedFromParseCompletionBlock)completionBlock;

-(void)requestAllTeamsForRegion:(NSString*)region
                 withCompletion:(TeamsRetrievedFromParseCompletionBlock)completionBlock;


@end
