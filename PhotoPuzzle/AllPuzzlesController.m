//
//  AllPuzzlesController.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AllPuzzlesController.h"
#import "NewPuzzleController.h"
#import "PuzzleController.h"
#import "Puzzle.h"
#import "ImageCache.h"


@implementation AllPuzzlesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *newPuzzleBarButtonItem = [[UIBarButtonItem alloc]
                                                   initWithTitle:@"New" style: UIBarButtonItemStyleBordered 
                                                   target:self action:@selector(newPuzzle:)];
        
        [[self navigationItem] setRightBarButtonItem:newPuzzleBarButtonItem];
        
        [newPuzzleBarButtonItem release];
        
        puzzles = [[NSMutableArray alloc] init];
        selectedPuzzle = [[Puzzle alloc] init];
         
        //[puzzles addObject:[Puzzle dummyPuzzle]];
    }
    
    return self;
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

- (void) viewWillAppear:(BOOL)animated
{    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.toolbar.hidden = YES;
    
    if ([puzzles count] > 0) {
        selectedPuzzle = [puzzles objectAtIndex:0];
        [[self navigationItem] setTitle:[selectedPuzzle puzzleName]];        
        [prevButton setHidden:NO];
        [nextButton setHidden:NO];
        [noPuzzlesLabel setHidden:YES];
        [startButton setHidden:NO];
        
        NSString *imageKey = [selectedPuzzle imageKey];
        
        if (imageKey) {
            UIImage *imageToDisplay = [[ImageCache sharedImageCache] imageForKey:imageKey];
            [imageView setImage:imageToDisplay];
        }
        else
        {
            [imageView setImage:nil];
        }
    }
    else
    {
        [prevButton setHidden:YES];
        [nextButton setHidden:YES];
        [noPuzzlesLabel setHidden:NO];
        [startButton setHidden:YES];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [nextButton release];
    nextButton = nil;
    [prevButton release];
    prevButton = nil;
    [imageView release];
    imageView = nil;
    [startButton release];
    startButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) newPuzzle:(id)sender
{    
    newPuzzleController = [[NewPuzzleController alloc] init];
    newPuzzleController.delegate = self;
    
    [[self navigationController]  pushViewController:newPuzzleController  animated:YES];
}

- (IBAction) startGame
{
    puzzleController = [[PuzzleController alloc] init];
    [puzzleController setPuzzleImage:[imageView image]];
    [puzzleController setNumVerticalPieces:[selectedPuzzle numPieces]];
    [puzzleController setNumHorizontalPieces:[selectedPuzzle numPieces]];
    
    puzzleController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [[self navigationController] pushViewController:puzzleController animated:YES];
}

- (void)receivePuzzle:(Puzzle *)message 
{
	NSLog([NSString stringWithFormat:@"%d", message.numPieces]);
    [puzzles addObject:message];
}

@end
