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

@interface LCSRecapUtilities()

@property (nonatomic, strong) ParseDatabaseUtility *parseDatabaseUtility;
@property (nonatomic, strong) PersistencyManager *persistencyManager;
@end

@implementation LCSRecapUtilities

+(void)initializeLCSRecapApp
{
    
    [SeasonModel registerSubclass];
    
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

-(void)saveCurrentState
{
    [self.persistencyManager saveData];
}

@end
