//
//  PersistencyManager.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistencyManager : NSObject

-(NSArray *)getSeasonsForRegion:(NSString*)region;
-(NSArray *)getAllTeamsForRegion:(NSString*)region;

-(void)addSeasonsArrayToDictionary:(NSArray*)seasons
                    forRegion:(NSString*)region;

-(void)addTeamArray:(NSArray*)team
ToDictionaryForRegion:(NSString*)region

          forSeason:(NSString*)season;

-(void)saveData;

@property (nonatomic, strong) NSDate *lastSavedDate;

@end
