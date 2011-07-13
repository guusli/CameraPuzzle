//
//  PuzzleItemCell.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Puzzle;

@interface PuzzleItemCell : UITableViewCell 
{
    UILabel *nameLabel;
    UIImageView *imageView;
}

- (void) setPuzzle:(Puzzle *)puzzle;

@end
