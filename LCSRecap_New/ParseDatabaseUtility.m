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
#import "TeamModel.h"
#import "PlayerModel.h"
#import "EventWeekModel.h"


@implementation ParseDatabaseUtility

-(void)requestAllSeasonsForRegion:(NSString *)region withCompletion:(SeasonRetrievedFromParseCompletionBlock)completionBlock
{
    PFQuery *query = [SeasonModel query];
    [query whereKey:@"region" equalTo:region];
    [query orderByAscending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (completionBlock)
        {
            completionBlock(YES, error, objects);
        }
    }];
    
}

-(void)requestAllTeamsForRegion:(NSString*)region
                 withCompletion:(TeamsRetrievedFromParseCompletionBlock)completionBlock
{
    PFQuery *query = [TeamModel query];
    [query whereKey:@"region" equalTo:region];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (completionBlock)
        {
            completionBlock(YES, error, objects);
        }
    }];
}

-(void)requestPlayersForTeam:(TeamModel *)team withCompletion:(PlayersRetrievedFromParseCompletionBlock)completionBlock
{
    PFQuery *query = [PlayerModel query];
    [query whereKey:@"season" equalTo:team.season];
    [query whereKey:@"teamKey" equalTo:team.key];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        completionBlock(YES, error, objects);
    }];
}

-(void)requestEventWeeksForRegion:(NSString*)region forSeason:(NSString*)season forEvent:(NSString*)event withCompletion:(EventWeekRetrievedFromParseCompletionBlock)completionBlock
{
    PFQuery *query = [EventWeekModel query];
    [query whereKey:@"season" equalTo:season];
    [query whereKey:@"event" equalTo:event];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && objects.count > 0 )
            completionBlock(YES, error, objects);
    }];
    
}


@end
