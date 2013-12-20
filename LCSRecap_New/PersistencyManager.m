//
//  PersistencyManager.m
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import "PersistencyManager.h"

@interface PersistencyManager()

@property (nonatomic, strong) NSMutableDictionary *allSeasonsDictionary;

@end


@implementation PersistencyManager

-(id)init
{
    self = [super init];
    if (self)
    {
        //TODO: Add update logic to update after an elapsed time.
        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/seasons.bin"]];
        
        self.allSeasonsDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if (self.allSeasonsDictionary == nil)
        {
            self.allSeasonsDictionary = [[NSMutableDictionary alloc] init];
            NSLog(@"No Previous data detected");

        }
        else
        {
            NSLog(@"Did Retrieve saved Data");
        }
    }
    
    return self;
}

-(NSArray *)getSeasonsForRegion:(NSString *)region
{
    return self.allSeasonsDictionary[region];
}

-(void)addSeasonsArrayToDictionary:(NSArray*)seasons
                         forRegion:(NSString*)region
{
    //TODO: Add More defensive code
    [self.allSeasonsDictionary setObject:seasons forKey:region];
    
}

-(void)saveData
{
    [self saveAllSeasonsDictionary];
}

-(void)saveAllSeasonsDictionary
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/seasons.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.allSeasonsDictionary];
    [data writeToFile:filename atomically:YES];
    NSLog(@"Wrote data to file");
}

@end
