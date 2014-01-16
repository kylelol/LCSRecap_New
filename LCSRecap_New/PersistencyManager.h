//
//  PersistencyManager.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TeamModel;

@interface PersistencyManager : NSObject

-(NSArray *)getSeasonsForRegion:(NSString*)region;
-(NSArray *)getAllTeamsForRegion:(NSString*)region;
-(NSArray *)getPlayersForTeam:(TeamModel*)team;
-(TeamModel*)getTeamForRegion:(NSString*)region ForSeason:(NSString*)season withTeamKey:(NSString*)key;

-(void)addSeasonsArrayToDictionary:(NSArray*)seasons
                    forRegion:(NSString*)region;

-(void)addTeamArray:(NSArray*)team
ToDictionaryForRegion:(NSString*)region

          forSeason:(NSString*)season;
-(void)addPlayers:(NSArray*)players toTeam:(TeamModel*)team;

-(void)saveData;
-(void)saveImage:(UIImage *)image filename:(NSString *)filename;
-(UIImage *)getImage:(NSString *)filename;

@property (nonatomic, strong) NSDate *lastSavedDate;

@end
