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
    
    NSMutableArray *puzzles;
    
    NewPuzzleController *newPuzzleController;
    PuzzleController *puzzleController;
    
    Puzzle *selectedPuzzle;

}

- (IBAction) newPuzzle:(id)sender;
- (IBAction) startGame;

@end
