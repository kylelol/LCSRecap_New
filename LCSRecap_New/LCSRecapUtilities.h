//
//  LCSRecapUtilities.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/18/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TeamModel;

typedef void (^SeasonRetrievedCompletionBlock)(BOOL success, NSError *error, NSArray *seasons);
typedef void (^TeamsRetrievedCompletionBlock)(BOOL success, NSError *error, NSArray *teams);
typedef void (^TeamLogoRetrievedCompletionBlock)(BOOL success, UIImage *teamLogo);
typedef void (^PlayersRetrievedCompletionBlock)(BOOL success,  TeamModel *newTeam);
typedef void (^EventWeekRetrievedCompletionBLock)(BOOL success, NSArray *events);


@interface LCSRecapUtilities : NSObject

+(void)initializeLCSRecapApp;

#pragma mark - SingleTon
+(instancetype)sharedUtilities;

#pragma mark - LCSRecap API

-(NSString*)getSeasonTitleForRegion:(NSString*)region
                            atIndex:(NSUInteger)index;

-(void)getAllSeasonsForRegion:(NSString *)region
                   withCompletion:(SeasonRetrievedCompletionBlock)completionBlock;

-(void)getEventWeeksForRegion:(NSString*)region forSeason:(NSString*)season forEvent:(NSString*)event withCompletion:(EventWeekRetrievedCompletionBLock)completionBlock;

-(void)getAllTeamsForRegion:(NSString*)region
             withCompletion:(TeamsRetrievedCompletionBlock)completionBlock;

-(void)getTeamLogoForUrl:(NSString*)url
          withCompletion:(TeamLogoRetrievedCompletionBlock)completionBlock;

-(void)getPlayersForTeam:(TeamModel*)team
          withCompletion:(PlayersRetrievedCompletionBlock)completionBlock;

-(void)saveCurrentState;

@end
