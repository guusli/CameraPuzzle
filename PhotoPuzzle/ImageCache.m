//
//  ImageCache.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"

static ImageCache *sharedImageCache;

@implementation ImageCache

- (id)init
{
    [super init];
    dictionary = [[NSMutableDictionary alloc] init];
    return self;
}

#pragma mark Accessing the cache

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
    
    // Fullständig path för bilden
    NSString *imagePath = pathInDocumentDirectory(s);
    // Gör om till JPEG
    NSData *d = UIImageJPEGRepresentation(i, 0.5);
    // Skriv
    [d writeToFile:imagePath atomically:YES];
}


- (UIImage *)imageForKey:(NSString *)s
{
    // Om möjligt, hämta från dictionary
    UIImage *result = [dictionary objectForKey:s];
    
    if (!result) {
        // Skapa från fil
        result = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(s)];
        
        if (result) {
            [dictionary setObject:result forKey:s]; // Lägg till i dictionary
        }
        else
            NSLog(@"Error: unable to find %@", pathInDocumentDirectory(s));
    }
    
    return result;
}

- (void)deleteImageForKey:(NSString *)s
{
    [dictionary removeObjectForKey:s];
    NSString *path = pathInDocumentDirectory(s);
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

#pragma mark Singleton stuff

+ (ImageCache *)sharedImageCache
{
    if (!sharedImageCache) {
        sharedImageCache = [[ImageCache alloc] init];
    }
    
    return sharedImageCache;
}

+ (id)allocWithZone:(NSZone *)zone
{
    if (!sharedImageCache) {
        sharedImageCache = [super allocWithZone:zone];
        return sharedImageCache;
    }
    else
    {
        return nil;
    }
}

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)release
{
    // No op
}

@end
