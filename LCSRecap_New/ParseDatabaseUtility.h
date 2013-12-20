//
//  ParseDatabaseUtility.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/19/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SeasonRetrievedFromParseCompletionBlock)(BOOL success, NSError *error, NSArray *seasons);

@interface ParseDatabaseUtility : NSObject

-(void)requestAllSeasonsForRegion:(NSString*)region
                   withCompletion:(SeasonRetrievedFromParseCompletionBlock)completionBlock;

@end
