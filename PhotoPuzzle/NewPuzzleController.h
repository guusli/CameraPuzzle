//
//  NewPuzzleController.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Puzzle;

@interface NewPuzzleController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *nameField;
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *saveButton;
    
    Puzzle *newPuzzle;
    
}

@property (nonatomic, assign) Puzzle *newPuzzle;

- (IBAction) savePuzzle;

@end
