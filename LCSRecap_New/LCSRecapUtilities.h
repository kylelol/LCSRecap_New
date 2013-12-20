//
//  LCSRecapUtilities.h
//  LCSRecap
//
//  Created by Kyle Kirkland on 12/18/13.
//  Copyright (c) 2013 Kyle Kirkland. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SeasonRetrievedCompletionBlock)(BOOL success, NSError *error, NSArray *seasons);

@interface LCSRecapUtilities : NSObject

+(void)initializeLCSRecapApp;

#pragma mark - SingleTon
+(instancetype)sharedUtilities;

#pragma mark - LCSRecap API
-(void)getAllSeasonsForRegion:(NSString *)region
                   withCompletion:(SeasonRetrievedCompletionBlock)completionBlock;

-(void)saveCurrentState;

@end
