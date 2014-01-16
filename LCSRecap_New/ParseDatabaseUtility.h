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
typedef void (^PlayersRetrievedFromParseCompletionBlock)(BOOL success, NSError *error, NSArray *players);
typedef void (^EventWeekRetrievedFromParseCompletionBlock)(BOOL success, NSError *error, NSArray *eventWeeks);

@class SeasonModel;
@class TeamModel;

@interface ParseDatabaseUtility : NSObject

-(void)requestAllSeasonsForRegion:(NSString*)region
                   withCompletion:(SeasonRetrievedFromParseCompletionBlock)completionBlock;

-(void)requestAllTeamsForRegion:(NSString*)region
                 withCompletion:(TeamsRetrievedFromParseCompletionBlock)completionBlock;

-(void)requestPlayersForTeam:(TeamModel*)team
              withCompletion:(PlayersRetrievedFromParseCompletionBlock)completionBlock;
-(void)requestEventWeeksForRegion:(NSString*)region forSeason:(NSString*)season forEvent:(NSString*)event withCompletion:(EventWeekRetrievedFromParseCompletionBlock)completionBlock;


@end
