//
//  StartMenuController.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewPuzzleController;

@interface StartMenuController : UIViewController 
{
    IBOutlet UIButton *startButton;
    
    NewPuzzleController *newPuzzleController;
}

- (IBAction) startGame;

@end
