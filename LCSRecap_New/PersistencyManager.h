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

-(void)addSeasonsArrayToDictionary:(NSArray*)seasons
                    forRegion:(NSString*)region;

-(void)saveData;

@end
