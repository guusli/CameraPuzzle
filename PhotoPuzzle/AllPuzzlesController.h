//
//  AllPuzzlesController.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewPuzzleController, Puzzle, PuzzleController;

@protocol AllPuzzlesDelegate

- (void)receivePuzzle:(Puzzle *)message;

@end


@interface AllPuzzlesController : UIViewController <AllPuzzlesDelegate>
{ 
    IBOutlet UIButton *nextButton;
    IBOutlet UIButton *prevButton;
    IBOutlet UIButton *startButton;
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *noPuzzlesLabel;
    IBOutlet UIToolbar *toolbar;
    
    NSMutableArray *puzzles;
    
    NewPuzzleController *newPuzzleController;
    PuzzleController *puzzleController;
    
    Puzzle *selectedPuzzle;
    int currentIndex;

}

- (IBAction) newPuzzle:(id)sender;
- (IBAction) prevPuzzle:(id)sender;
- (IBAction) nextPuzzle:(id)sender;
- (IBAction) startGame:(id)sender;

- (void) changePuzzleToIndex:(int)index;
- (void) enableButtons;

@end
