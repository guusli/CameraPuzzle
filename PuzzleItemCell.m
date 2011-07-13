//
//  PuzzleItemCell.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PuzzleItemCell.h"
#import "Puzzle.h"


@implementation PuzzleItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:nameLabel];
        [nameLabel release];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:imageView];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView release];
    }
    
    return self;
}

- (void) layoutSubviews
{
    float inset = 5.0;
    CGRect bounds = [[self contentView] bounds];
    float h = bounds.size.height;
    float w = bounds.size.width;
    
    CGRect innerFrame = CGRectMake(inset, inset, h, h - inset * 2.0);
    [imageView setFrame:innerFrame];
    
    innerFrame.origin.x += innerFrame.size.width + inset;
    innerFrame.size.width = w - (h + 40 + inset * 4);
    [nameLabel setFrame:innerFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

- (void)setPuzzle:(Puzzle *)puzzle
{
    [nameLabel setText:[puzzle puzzleName]];
    [imageView setImage:[puzzle thumbnail]];
}

@end
