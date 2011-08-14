//
//  SliderController.h
//  SliderPuzzleDemo
//
//  Created by Joshua Newnham on 15/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tile.h"

#define TILE_SPACING			4

#define SHUFFLE_NUMBER	100

typedef enum {
	NONE			= 0,
	UP				= 1,
	DOWN			= 2, 
	LEFT			= 3,
	RIGHT			= 4
} ShuffleMove;

@interface PuzzleController : UIViewController {
    
    int numHorizontalPieces, numVerticalPieces;
    
	CGFloat tileWidth; 
	CGFloat tileHeight;
	
	NSMutableArray *tiles; 
	CGPoint blankPosition; 
    
    UIImage *puzzleImage;
    
    BOOL isMoving;
    Tile *toBeMoved;
    
}

@property (nonatomic) int numHorizontalPieces;
@property (nonatomic) int numVerticalPieces;
@property (nonatomic,retain) NSMutableArray *tiles;
@property (nonatomic,retain) Tile *toBeMoved;
@property (nonatomic, retain) UIImage *puzzleImage;

@end
