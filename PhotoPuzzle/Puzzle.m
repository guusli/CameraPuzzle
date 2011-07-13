//
//  Puzzle.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Puzzle.h"


@implementation Puzzle

@synthesize puzzleName, imageKey;

+ (id) dummyPuzzle
{
    Puzzle *newPuzzle = [[self alloc] initWithPuzzleName:@"Puzzle" imageKey:@""];
    
    return newPuzzle;
}

- (id) initWithPuzzleName:(NSString *)name imageKey:(NSString *)key
{
    [super init];
    
    if (!self) {
        return nil;
    }
    
    [self setPuzzleName:name];
    [self setImageKey:key];
    
    return self;
}

@end
