//
//  PuzzleTableController.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewPuzzleController, Puzzle, PuzzleController;

@interface PuzzleTableController : UITableViewController 
{
    NSMutableArray *puzzles;
    NewPuzzleController *newPuzzleController;
    PuzzleController *puzzleController;
}

@end
