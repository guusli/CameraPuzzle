//
//  PuzzleTableController.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PuzzleTableController.h"
#import "Puzzle.h"
#import "NewPuzzleController.h"
#import "PuzzleItemCell.h"
#import "PuzzleController.h"
#import "ImageCache.h"


@implementation PuzzleTableController

- (id) init
{
    [super initWithStyle:UITableViewStyleGrouped];
    
    puzzles = [[NSMutableArray alloc] init];
    
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    [puzzles addObject:[Puzzle dummyPuzzle]];
    UIBarButtonItem *newPuzzleBarButtonItem = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newPuzzle:)];
    
    [[self navigationItem] setRightBarButtonItem:newPuzzleBarButtonItem];
    [[self navigationItem] setTitle:@"All Puzzles"];
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if ([puzzles count] > 0 && ([[puzzles objectAtIndex:[puzzles count] -1] bestScore] < 0  
//            || [[puzzles objectAtIndex:[puzzles count] -1] imageKey] == nil))
//    {
//        [puzzles removeObjectAtIndex:[puzzles count]-1];
//    }
    [[self tableView] reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [puzzles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PuzzleItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PuzzleItemCell alloc]
                    initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier] autorelease];
        
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Puzzle *p = [puzzles objectAtIndex:[indexPath row]];
    //[[cell textLabel] setText:[p puzzleName]];
    [cell setPuzzle:p];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Puzzle *p = [puzzles objectAtIndex:[indexPath row]];
//    UIImage *image = [[ImageCache sharedImageCache] imageForKey:[p imageKey]];
    puzzleController = [PuzzleController alloc];
    //UIImage *image = [UIImage imageNamed:@"winnipeg.png"];
    [puzzleController initPuzzle:[p image]];
    
    [[self navigationController] pushViewController:puzzleController animated:YES];
}

- (void) newPuzzle:(id)sender
{
    if (!newPuzzleController) {
        newPuzzleController = [[NewPuzzleController alloc] init];
    }
    
    [puzzles addObject:[Puzzle dummyPuzzle]];
    [[puzzles objectAtIndex:[puzzles count]-1] setPuzzleName:@"Bajs"];
    [newPuzzleController setNewPuzzle:[puzzles objectAtIndex:[puzzles count]-1]];
    
    [[self navigationController] pushViewController:newPuzzleController animated:YES];
}



@end
