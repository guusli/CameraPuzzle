//
//  Puzzle.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Puzzle : NSObject <NSCoding>
{
    NSString *puzzleName;
    NSString *imageKey;
    int bestScore;
    int numPieces;
    UIImage *thumbnail;
    NSData *thumbnailData;
    UIImage *puzzleImage;
    NSData *imageData;
    BOOL isPuzzleComplete;
}

@property (nonatomic, copy) NSString *puzzleName;
@property (nonatomic, copy) NSString *imageKey;
@property (nonatomic) int bestScore;
@property (nonatomic) int numPieces;
@property (readonly) UIImage *thumbnail;
@property (readonly) UIImage *puzzleImage;
@property BOOL isPuzzleComplete;

+ (id) dummyPuzzle;
- (id) initWithPuzzleName:(NSString *)name;
- (void) setThumbnailDataFromImage:(UIImage *)image;
- (void) setImageData:(UIImage *)image;

@end
