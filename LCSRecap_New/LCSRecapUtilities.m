//
//  LCSRecapUtilities.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/18/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "LCSRecapUtilities.h"
#import <Parse/Parse.h>
#import "ParseDatabaseUtility.h"
#import "PersistencyManager.h"
#import "SeasonModel.h"
#import "TeamModel.h"
#import "PlayerModel.h"
#import "EventWeekModel.h"

@interface LCSRecapUtilities()

@property (nonatomic, strong) ParseDatabaseUtility *parseDatabaseUtility;
@property (nonatomic, strong) PersistencyManager *persistencyManager;
@end

@implementation LCSRecapUtilities

+(void)initializeLCSRecapApp
{
    
    [SeasonModel registerSubclass];
    [TeamModel registerSubclass];
    [PlayerModel registerSubclass];
    [EventWeekModel registerSubclass];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"];
    NSDictionary *keys = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // Debug Code
    //NSLog(@"Client Key: %@\n App Key:%@", keys[@"parse-client-id"], keys[@"parse-app-id"]);
    
    [Parse setApplicationId:keys[@"parse-app-id"]
                  clientKey:keys[@"parse-client-id"]];
    
}

+(instancetype)sharedUtilities
{
    static LCSRecapUtilities *sharedUtilities;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUtilities = [[LCSRecapUtilities alloc] init];
        
    });
    
    return sharedUtilities;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.persistencyManager = [[PersistencyManager alloc] init];
        self.parseDatabaseUtility = [[ParseDatabaseUtility alloc] init];
        
    }
    
    return self;
}

#pragma mark - LCSRecap API
-(void)getAllSeasonsForRegion:(NSString *)region
                    withCompletion:(SeasonRetrievedCompletionBlock)completionBlock
{    
    if (![self.persistencyManager getSeasonsForRegion:region])
    {
        [self.parseDatabaseUtility requestAllSeasonsForRegion:region withCompletion:^(BOOL success, NSError *error, NSArray *seasons)
        {
            if (!error)
            {
                [self.persistencyManager addSeasonsArrayToDictionary:seasons forRegion:region];
                [self saveCurrentState];
            
                if (completionBlock)
                {
                    completionBlock(YES, error, [self.persistencyManager getSeasonsForRegion:region]);
                }
            }
            else
            {
                //TODO: Handle Error
            }
            
        }];
        
    }
    else
    {
        if (completionBlock)
        {
            completionBlock(YES, nil, [self.persistencyManager getSeasonsForRegion:region]);
        }
    }
    
}

-(void)getEventWeeksForRegion:(NSString*)region forSeason:(NSString*)season forEvent:(NSString*)event withCompletion:(EventWeekRetrievedCompletionBLock)completionBlock
{
    
    [self.parseDatabaseUtility requestEventWeeksForRegion:region forSeason:season forEvent:event
                                           withCompletion:^(BOOL success, NSError *error, NSArray *eventWeeks) {
                                               if (eventWeeks)
                                                   NSLog(@"%@---yes", eventWeeks);
                                               completionBlock(YES, eventWeeks);
                                           }];
    
}

-(void)getAllTeamsForRegion:(NSString *)region withCompletion:(TeamsRetrievedCompletionBlock)completionBlock
{
    NSArray *seasons = [self.persistencyManager getSeasonsForRegion:region];
    
    if (seasons)
    {
        // Check to see if teams are already alocated.
        if ( [[self.persistencyManager getAllTeamsForRegion:region] count] == 0 )
        {
            //if not request them from database utility
            [self.parseDatabaseUtility requestAllTeamsForRegion:region withCompletion:^(BOOL success, NSError *error, NSArray *teams) {
                
                if (success)
                {
                    // Separate them into seasons. 
                    for( int i=0; i < seasons.count; i++)
                    {
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        
                        for(int j=0; j < teams.count; j++)
                        {
                            if ( [((SeasonModel*)seasons[i]).key isEqualToString:((TeamModel*)teams[j]).season])
                            {
                                
                                [array addObject:teams[j]];
                            }
                            
                        }
                        
                        [self.persistencyManager addTeamArray:[NSArray arrayWithArray:array]
                                        ToDictionaryForRegion:region
                                                    forSeason:((SeasonModel*)seasons[i]).key];
                    }
                    
                    [self saveCurrentState];;
                    
                    if (completionBlock)
                        completionBlock(YES, error, [self.persistencyManager getAllTeamsForRegion:region]);
                }
            }];

        }
        else
        {
            // Send the saved ones.
            if (completionBlock)
                completionBlock(YES,nil, [self.persistencyManager getAllTeamsForRegion:region]);
        }
        
        
    }

    
}

-(void)getTeamLogoForUrl:(NSString *)url withCompletion:(TeamLogoRetrievedCompletionBlock)completionBlock
{
    
    UIImage *image = [self.persistencyManager getImage:[url lastPathComponent]];
    NSLog(@"%@", [url lastPathComponent]);
    
    if (image == nil)
    {
        NSLog(@"Loads image");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
            dispatch_sync(dispatch_get_main_queue(), ^{
            
                if ( completionBlock)
                {
                    completionBlock(YES, [UIImage imageWithData:imageData]);
                    [self.persistencyManager saveImage:[UIImage imageWithData:imageData] filename:[url lastPathComponent]];
                }
            });
        
        });
    }
    else
    {
        if (completionBlock)
            completionBlock(YES, image);
    }
}

-(void)getPlayersForTeam:(TeamModel *)team withCompletion:(PlayersRetrievedCompletionBlock)completionBlock
{
    if ( ![self.persistencyManager getPlayersForTeam:team])
    {
        NSLog(@"need to retrieve teams");
        
        [self.parseDatabaseUtility requestPlayersForTeam:team withCompletion:^(BOOL success, NSError *error, NSArray *players)
        {
            [self.persistencyManager addPlayers:players toTeam:team];
            
            if (completionBlock)
                completionBlock(YES, [self.persistencyManager getTeamForRegion:team.region ForSeason:team.season withTeamKey:team.key]);
        }];
        
    }
    else
    {
        if (completionBlock)
            completionBlock(YES, [self.persistencyManager getTeamForRegion:team.region ForSeason:team.season withTeamKey:team.key]);
    }

}

-(NSString*)getSeasonTitleForRegion:(NSString*)region atIndex:(NSUInteger)index
{
    NSArray *seasons = [self.persistencyManager getSeasonsForRegion:region];
    
    if (seasons)
    {
        return ((SeasonModel*)seasons[index]).name;
    }
    
    return nil;
}


-(void)saveCurrentState
{
    [self.persistencyManager saveData];
}

@end
