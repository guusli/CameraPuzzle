//
//  Puzzle.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Puzzle.h"


@implementation Puzzle

@synthesize puzzleName, imageKey, bestScore, puzzleImage, isPuzzleComplete, numPieces;

+ (id) dummyPuzzle
{
    Puzzle *newPuzzle = [[[self alloc] initWithPuzzleName:@"Puzzle"] autorelease];
    
    return newPuzzle;
}

- (id) init
{
    return [self initWithPuzzleName:@""];
}

- (id) initWithPuzzleName:(NSString *)name
{
    [super init];
    
    if (!self) {
        return nil;
    }
    
    [self setPuzzleName:name];
    bestScore = -1;
    
    return self;
}

- (void) dealloc
{
    [thumbnail release];
    [thumbnailData release];
    [puzzleName release];
    [imageKey release];
    
    [super dealloc];
}

- (void)setThumbnailDataFromImage:(UIImage *)image
{
    [thumbnailData release];
    [thumbnail release];
    
    CGRect imageRect = CGRectMake(0, 0, 70, 70);
    UIGraphicsBeginImageContext(imageRect.size);
    
    [image drawInRect:imageRect];
    
    thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    [thumbnail retain];
    
    UIGraphicsEndImageContext();
    
    thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.5);
    
    [thumbnailData retain];
}

- (void) setImageData:(UIImage *)image
{
    [image release];
    
    CGRect imageRect = CGRectMake(0, 0, 312, 408);
    UIGraphicsBeginImageContext(imageRect.size);
    
    [image drawInRect:imageRect];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    [image retain];
    
    UIGraphicsEndImageContext();
    
    imageData = UIImagePNGRepresentation(image);
    [imageData retain];
}

// getter method
- (UIImage *)thumbnail
{
    if (!thumbnailData) {
        return nil;
    }
    
    if (!thumbnail) {
        thumbnail = [[UIImage imageWithData:thumbnailData] retain];
    }
    
    return  thumbnail;
}

- (UIImage *) puzzleImage
{
    if (!imageData) {
        return nil;
    }
    if (!puzzleImage) {
        puzzleImage = [[UIImage imageWithData:imageData] retain];
    }
    
    return puzzleImage;
}

@end
