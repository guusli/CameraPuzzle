//
//  Puzzle.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Puzzle : NSObject 
{
    NSString *puzzleName;
    NSString *imageKey;
}

@property (nonatomic, copy) NSString *puzzleName;
@property (nonatomic, copy) NSString *imageKey;

- (id) initWithPuzzleName:(NSString *)name imageKey:(NSString *)key;

@end
