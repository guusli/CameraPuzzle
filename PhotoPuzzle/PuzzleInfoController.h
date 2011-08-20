//
//  PuzzleInfoController.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Puzzle;

@protocol AllPuzzlesDelegate;

@interface PuzzleInfoController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    id<AllPuzzlesDelegate> delegate;
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIButton *removeButton;
    IBOutlet UIButton *closeButton;
    
    Puzzle *puzzle;
    
    NSMutableArray *dataForTable;
}

@property (nonatomic, retain) Puzzle *puzzle;
@property (nonatomic, assign) id<AllPuzzlesDelegate> delegate;

- (IBAction) closeView;
- (IBAction) removePuzzle;

@end
