//
//  PuzzleInfoController.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PuzzleInfoController.h"
#import "ImageCache.h"
#import "Puzzle.h"
#import "AllPuzzlesController.h"

@implementation PuzzleInfoController

@synthesize puzzle,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [imageView release];
    [nameLabel release];
    [removeButton release];
    [closeButton release];
    
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
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 150, 280, 250) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView release];
    
    [nameLabel setText:[puzzle puzzleName]];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [closeButton setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [removeButton setBackgroundImage:[UIImage imageNamed:@"button_red.png"] forState:UIControlStateNormal];
    [removeButton setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:removeButton];
    
    NSString *imageKey = [puzzle imageKey];
    
    if (imageKey)
    {
        UIImage *imageToDisplay = [[ImageCache sharedImageCache] imageForKey:imageKey];
        [imageView setImage:imageToDisplay];
    }
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [imageView release];
    imageView = nil;
    [nameLabel release];
    nameLabel = nil;
    [removeButton release];
    removeButton = nil;
    [closeButton release];
    closeButton = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	switch (section) 
    {
		case 0:
			return 1;
			break;
		case 1:
			return 3;
			break;
	}
	
	return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return nil;
			break;
		case 1:
			return @"Best Scores";
			break;
	}
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
         
    NSLog(@"cellForRowAtIndexPath called");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) { NSLog(@"newCell");
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"] autorelease];
    }
    
    if (indexPath.section == 0) 
    {
        [[cell textLabel] setText:[NSString stringWithFormat:@"Number of Pieces",indexPath.row]];
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d x %d",[puzzle numPieces],[puzzle numPieces]]];
    }
    else
    {
        [[cell textLabel] setText:[NSString stringWithFormat:@"...",indexPath.row]];
        [[cell detailTextLabel] setText:@"0"];
    }
    
    return cell;
}

- (IBAction) closeView
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) removePuzzle
{
    [delegate receiveRemoveOrder];
    [self dismissModalViewControllerAnimated:YES];
}
     
@end
