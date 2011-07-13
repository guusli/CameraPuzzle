//
//  Tile.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tile : UIImageView 
{
    CGPoint originalPosition; 
	CGPoint currentPosition;
}

@property (nonatomic, readwrite) CGPoint originalPosition;
@property (nonatomic, readwrite) CGPoint currentPosition;

@end
