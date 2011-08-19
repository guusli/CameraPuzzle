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
#import <QuartzCore/QuartzCore.h>


#define PREVIOUS -1
#define NEXT 1

@implementation AllPuzzlesController

@synthesize puzzles;

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
        currentIndex = 0;
         
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
    
    if ([puzzles count] > 0) {
        
        [self changePuzzleToIndex:currentIndex inDirection:NEXT];
    
        [self enableButtons];
        [noPuzzlesLabel setHidden:YES];

    }
    else
    {
        [[toolbar.items objectAtIndex:0] setEnabled:NO]; // Previous
        [[toolbar.items objectAtIndex:2] setEnabled:NO]; // Go!
        [[toolbar.items objectAtIndex:4] setEnabled:NO]; // Next
        [noPuzzlesLabel setHidden:NO];
        [startButton setHidden:YES];
    }
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release]; 
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [prevPuzzleImageView removeFromSuperview];
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

- (IBAction) prevPuzzle:(id)sender
{
    if (currentIndex == 0)
        return;
    currentIndex--;
    [self changePuzzleToIndex:currentIndex inDirection:PREVIOUS];
}

- (IBAction) nextPuzzle:(id)sender
{
    NSLog([NSString stringWithFormat:@"Cunt: %d", [puzzles count]]);
    if (currentIndex+1 == [puzzles count])
        return;
    currentIndex++;
    [self changePuzzleToIndex:currentIndex inDirection:NEXT];
}

- (IBAction) startGame:(id)sender
{
    puzzleController = [[PuzzleController alloc] init];
    [puzzleController setPuzzleImage:[imageView image]];
    [puzzleController setNumVerticalPieces:[selectedPuzzle numPieces]];
    [puzzleController setNumHorizontalPieces:[selectedPuzzle numPieces]];
    
    puzzleController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [[self navigationController] pushViewController:puzzleController animated:YES];
}

- (IBAction)showInfo:(id)sender
{
    // Visa Info
}

- (void)receivePuzzle:(Puzzle *)message 
{
	NSLog([NSString stringWithFormat:@"%d", message.numPieces]);
    [puzzles addObject:message];
}

- (void) changePuzzleToIndex:(int)index inDirection:(int)direction
{
    //UIImage *oldImage = imageView.image;
    selectedPuzzle = [puzzles objectAtIndex:index];
    
    NSString *imageKey = [selectedPuzzle imageKey];
    
    if (imageKey) {
       UIImage *imageToDisplay = [[ImageCache sharedImageCache] imageForKey:imageKey];
        
        UIImageView *newImageView = [[UIImageView alloc] initWithImage:imageToDisplay];
        [self.view addSubview:newImageView];
        newImageView.frame = CGRectMake(-400*direction, 20, 241, 319);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:imageView cache:YES];
        //[imageView setImage:imageToDisplay];
        
        newImageView.frame = CGRectMake(40, 20, 241, 319);
        imageView.frame = CGRectMake(40, 20, 241, 319);
        [UIView commitAnimations];
        
        
        [imageView setImage:imageToDisplay];
    }
    else
    {
        [imageView setImage:nil];
    }
    
    [[self navigationItem] setTitle:[selectedPuzzle puzzleName]];
    
    [self enableButtons];
    
}

- (void) enableButtons
{
    // Previous
    if (currentIndex == 0)
        [[toolbar.items objectAtIndex:0] setEnabled:NO];
    else
        [[toolbar.items objectAtIndex:0] setEnabled:YES];
    
    // Next
    if (currentIndex + 1 == [puzzles count])
        [[toolbar.items objectAtIndex:4] setEnabled:NO];
    else
        [[toolbar.items objectAtIndex:4] setEnabled:YES];
    
    // Go!
    if ([puzzles count] > 0)
        [[toolbar.items objectAtIndex:2] setEnabled:YES];
    else
        [[toolbar.items objectAtIndex:2] setEnabled:YES];
    
    
}

@end
