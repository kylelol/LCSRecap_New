//
//  PersistencyManager.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "PersistencyManager.h"
#import "TeamModel.h"

@interface PersistencyManager()

@property (nonatomic, strong) NSMutableDictionary *allSeasonsDictionary;
@property (nonatomic, strong) NSMutableDictionary *allTeamsDictionary;

@end


@implementation PersistencyManager

-(id)init
{
    self = [super init];
    if (self)
    {
        
        self.lastSavedDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSave"];
        NSLog(@"%@", self.lastSavedDate);

        NSInteger hours = [[[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self.lastSavedDate toDate:[NSDate date] options:0] hour];
        
        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/seasons.bin"]];
        NSData *teamData = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/teams.bin"]];
        
        if ( hours < 5)
        {
            self.allSeasonsDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            self.allTeamsDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:teamData];
            NSLog(@"Should Load Team Data");
        }
        
        if (self.allSeasonsDictionary == nil)
        {
            self.allSeasonsDictionary = [[NSMutableDictionary alloc] init];
            NSLog(@"No Previous data detected");

        }
        else
        {
            NSLog(@"Did Retrieve saved Data");
        }
        

        
        if (self.allTeamsDictionary == nil)
        {
            self.allTeamsDictionary = [[NSMutableDictionary alloc] init];
            NSLog(@"No Previous Team Data");
        }
        else
        {
            NSLog(@"Did Retrieve Saved Team Data");
        }
    }
    
    return self;
}

-(NSArray *)getSeasonsForRegion:(NSString *)region
{
    return self.allSeasonsDictionary[region];
}

-(NSArray *)getAllTeamsForRegion:(NSString *)region
{
    NSLog(@"%@", [self.allTeamsDictionary[region] class]);
    return [NSArray arrayWithArray:self.allTeamsDictionary[region]];
}

-(void)addSeasonsArrayToDictionary:(NSArray*)seasons
                         forRegion:(NSString*)region
{
    //TODO: Add More defensive code
    [self.allSeasonsDictionary setObject:seasons forKey:region];
    
}

-(void)addTeamArray:(NSArray*)team
ToDictionaryForRegion:(NSString*)region

          forSeason:(NSString*)season
{
    
    if (![self.allTeamsDictionary objectForKey:region])
    {
        NSMutableArray *dictionary = [[NSMutableArray alloc] init];
        
        [dictionary addObject:team];
        
        [self.allTeamsDictionary setObject:dictionary forKey:region];
        
        return;
        
    }
    
    BOOL seasonFound = NO;
    for (NSMutableArray *array in [self.allTeamsDictionary objectForKey:region])
    {
        if ( [((TeamModel*)array[0]).season isEqualToString:season])
        {
            NSLog(@"TESTTRUUE");
        }
    }
    
    if ( !seasonFound )
    {
        [[self.allTeamsDictionary objectForKey:region] addObject:team];
    }
    

        
}

-(void)saveImage:(UIImage *)image filename:(NSString *)filename
{
    NSLog(@"DId Save image");
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

-(UIImage *)getImage:(NSString *)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

-(void)saveData
{
    [self saveAllSeasonsDictionary];
    [self saveAllTeamsDictionary];
    
    self.lastSavedDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:self.lastSavedDate forKey:@"lastSave"];

}

-(void)saveAllTeamsDictionary
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/teams.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.allTeamsDictionary];
    [data writeToFile:filename atomically:YES];
}

-(void)saveAllSeasonsDictionary
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/seasons.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.allSeasonsDictionary];
    [data writeToFile:filename atomically:YES];
    NSLog(@"Wrote data to file");
}

@end
