//
//  PuzzleController.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PuzzleController.h"
#import "Tile.h"
#import <QuartzCore/QuartzCore.h>


@implementation PuzzleController

@synthesize tiles, toBeMoved;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [[self view] setBackgroundColor:[UIColor grayColor]];
	
	self.tiles = [[NSMutableArray alloc] init];
	
	[self initPuzzle:@"winnipeg.png"];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) initPuzzle:(NSString *)imagePath
{
    UIImage *originalImage = [UIImage imageNamed:imagePath];
    
    [[self tiles] removeAllObjects];
    
    tileWidth = originalImage.size.width / NUM_HORIZONTAL_PIECES;
    tileHeight = originalImage.size.height / NUM_VERTICAL_PIECES;
    
    
    for (int x=0; x < NUM_HORIZONTAL_PIECES; x++) {
        for (int y=0; y<NUM_VERTICAL_PIECES; y++) {
            
            CGPoint orginalPosition = CGPointMake(x, y);
            
            CGRect frame = CGRectMake(tileWidth*x, tileHeight*y, 
                                      tileWidth, tileHeight);
            
            CGImageRef tileImageRef = CGImageCreateWithImageInRect(originalImage.CGImage, frame);
            UIImage *tileImage = [UIImage imageWithCGImage:tileImageRef];
            
            CGRect tileFrame = CGRectMake((tileWidth+TILE_SPACING)*x, (tileHeight+TILE_SPACING)*y, tileWidth, tileHeight);
            
            Tile *tileImageView = [[Tile alloc] initWithImage:tileImage];
            tileImageView.frame = tileFrame;
            tileImageView.originalPosition = orginalPosition;
            tileImageView.currentPosition = orginalPosition;
            
            [tileImage release];
            CGImageRelease(tileImageRef);
            
            [tiles addObject:tileImageView];
            
            [self.view insertSubview:tileImageView atIndex:0];
            [tileImageView release];
        }
    }
    
    [self shuffle];
}

-(void) swapTile:(Tile *) tile1 withTile:(Tile *) tile2 withAnimation:(BOOL) animate
{
    CGPoint temp = tile1.currentPosition;
	tile1.currentPosition = tile2.currentPosition;
    tile2.currentPosition = temp;

	
	int newX1 = tile1.currentPosition.x; 
	int newY1 = tile1.currentPosition.y;
    int newX2 = tile2.currentPosition.x; 
	int newY2 = tile2.currentPosition.y;
	
	if( animate ){
		[UIView beginAnimations:@"frame" context:nil];
	}
	tile1.frame = CGRectMake((tileWidth+TILE_SPACING)*newX1, (tileHeight+TILE_SPACING)*newY1, 
                            tileWidth, tileHeight );
    tile2.frame = CGRectMake((tileWidth+TILE_SPACING)*newX2, (tileHeight+TILE_SPACING)*newY2, 
                             tileWidth, tileHeight );
	if( animate ){
		[UIView commitAnimations];
	}
}

-(void) shuffle
{
	NSMutableArray *validMoves = [[NSMutableArray alloc] init];
	
	srandom(time(NULL));
	
	for( int i=0; i<SHUFFLE_NUMBER; i++ ){

		// randomly select a piece to move 
		NSInteger A = random()%[tiles count];
        NSInteger B = random()%[tiles count];
		//NSLog(@"shuffleRandom using pick: %d from array of size %d", pick, [validMoves count]);
		[self swapTile:[tiles objectAtIndex:A] withTile:[tiles objectAtIndex:B] withAnimation:YES];
	}
	
	[validMoves release];
}

#pragma mark User input

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if ([self puzzleCompleted]) 
    {
        return;
    }
    
	UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:self.view];	
    
	Tile *t = [self getPieceAtPoint:currentTouch];
    
    if (!isMoving) 
    {
        [t.layer setBorderColor: [[UIColor redColor] CGColor]];
        [t.layer setBorderWidth: 2.0];
        
        [self setToBeMoved:t];
        isMoving = YES;
    }
    else
    {
        [self swapTile:toBeMoved withTile:t withAnimation:YES];
        isMoving = NO;
        [toBeMoved.layer setBorderColor: [[UIColor clearColor] CGColor]];
        [toBeMoved.layer setBorderWidth: 2.0];
    }
    
    NSLog(@"Touch intercepted at %f, %f!",t.currentPosition.x, t.currentPosition.y);
}

- (Tile *) getPieceAtPoint:(CGPoint) point
{
	CGRect touchRect = CGRectMake(point.x, point.y, 1.0, 1.0);
	
	for( Tile *t in tiles ){
		if( CGRectIntersectsRect(t.frame, touchRect) ){
			return t; 
		}		
	}
	return nil;
}

-(BOOL) puzzleCompleted
{
	for( Tile *t in tiles ){
		if( t.originalPosition.x != t.currentPosition.x || t.originalPosition.y != t.currentPosition.y ){
			return NO;
		}
	}
	
	return YES; 
}

@end
