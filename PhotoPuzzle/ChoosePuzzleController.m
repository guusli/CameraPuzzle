//
//  StartMenuController.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-08-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartMenuController.h"
#import "NewPuzzleController.h"


@implementation StartMenuController

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

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.toolbar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction) startGame
{
    newPuzzleController = [[NewPuzzleController alloc] init];
    
    [[self navigationController] pushViewController:newPuzzleController animated:YES];
}

@end
