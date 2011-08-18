//
//  ImageCache.h
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageCache : NSObject 
{
    NSMutableDictionary *dictionary;
}

+ (ImageCache *)sharedImageCache;
- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *) imageForKey: (NSString *)s;
- (void)deleteImageForKey: (NSString *)s;

@end
