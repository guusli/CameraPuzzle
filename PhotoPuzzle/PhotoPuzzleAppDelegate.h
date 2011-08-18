//
//  PhotoPuzzleAppDelegate.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllPuzzlesController;

@interface PhotoPuzzleAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    AllPuzzlesController *startController;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
