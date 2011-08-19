//
//  FileHelpers.m
//  Homepwner
//
//  Created by Gustav Lindbergh on 2011-06-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Hjälpfil för filer

#include "FileHelpers.h"

NSString *pathInDocumentDirectory(NSString *fileName)
{
    // Get a list of document directories in sandbox
    NSArray *documentDirectories = 
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                        NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    // Append passed in file name to that directory, return it
    return [documentDirectory stringByAppendingPathComponent:fileName];
}
