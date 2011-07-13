//
//  Tile.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Tile.h"


@implementation Tile

@synthesize  originalPosition, currentPosition;

- (void) dealloc
{
    [self removeFromSuperview];
    [super dealloc];
}

@end
