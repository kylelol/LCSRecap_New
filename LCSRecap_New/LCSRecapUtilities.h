//
//  LCSRecapUtilities.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/18/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SeasonRetrievedCompletionBlock)(BOOL success, NSError *error, NSArray *seasons);
typedef void (^TeamsRetrievedCompletionBlock)(BOOL success, NSError *error, NSArray *teams);
typedef void (^TeamLogoRetrievedCompletionBlock)(BOOL success, UIImage *teamLogo);


@interface LCSRecapUtilities : NSObject

+(void)initializeLCSRecapApp;

#pragma mark - SingleTon
+(instancetype)sharedUtilities;

#pragma mark - LCSRecap API

-(NSString*)getSeasonTitleForRegion:(NSString*)region
                            atIndex:(NSUInteger)index;

-(void)getAllSeasonsForRegion:(NSString *)region
                   withCompletion:(SeasonRetrievedCompletionBlock)completionBlock;

-(void)getAllTeamsForRegion:(NSString*)region
             withCompletion:(TeamsRetrievedCompletionBlock)completionBlock;

-(void)getTeamLogoForUrl:(NSString*)url
          withCompletion:(TeamLogoRetrievedCompletionBlock)completionBlock;

-(void)saveCurrentState;

@end
