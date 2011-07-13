//
//  PuzzleController.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tile;

#define NUM_HORIZONTAL_PIECES	3
#define NUM_VERTICAL_PIECES		3

#define TILE_SPACING			4

#define SHUFFLE_NUMBER          100

@interface PuzzleController : UIViewController 
{
    CGFloat tileWidth;
    CGFloat tileHeight;
    
    NSMutableArray *tiles;
    
    Tile *toBeMoved;
    BOOL isMoving;
}

@property (nonatomic, retain) NSMutableArray *tiles;
@property (nonatomic, retain) Tile *toBeMoved;

-(void) initPuzzle:(NSString *) imagePath;
-(void) swapTile:(Tile *) tile1 withTile:(Tile *) tile2 withAnimation:(BOOL) animate;
-(void) shuffle;

-(Tile *) getPieceAtPoint:(CGPoint) point;
-(BOOL) puzzleCompleted;

@end
