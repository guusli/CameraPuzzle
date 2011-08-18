//
//  NewPuzzleController.m
//  PhotoPuzzle
//
//  Created by Gustav Lindbergh on 2011-07-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewPuzzleController.h"
#import "Puzzle.h"
#import "PuzzleController.h"
#import "AllPuzzlesController.h"
#import "ImageCache.h"

@implementation NewPuzzleController

@synthesize piecesSlider, piecesLabel;
@synthesize newPuzzle, puzzleImage;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *newPuzzleBarButtonItem = [[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemCamera 
                                                   target:self action:@selector(takePicture:)];
        
        [[self navigationItem] setRightBarButtonItem:newPuzzleBarButtonItem];
        [[self navigationItem] setTitle:@"New Puzzle"];
        
        [newPuzzleBarButtonItem release];
        
        newPuzzle = [[Puzzle alloc] init];
        
    }
    return self;
}

- (void)dealloc
{
    [imageView release];
    
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
//    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    
//    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:nil action:@selector(savePuzzle:)];
//    
//    NSArray *items = [NSArray arrayWithObjects: flexible, saveBarButtonItem, flexible, nil];
//    self.toolbarItems= items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    [imageView release];
    imageView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Image Picking Stuff

- (UIImage *)resizeImage:(UIImage *)image
{
    CGSize newSize = CGSizeMake(312.0, 408.0);
    UIGraphicsBeginImageContext( newSize );// a CGSize that has the size you want
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    //image is the original UIImage
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)takePicture:(id)sender
{
    UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentModalViewController:imagePicker animated:YES];
    
    [imagePicker release];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Skapa unik nyckel
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    [newPuzzle setImageKey:(NSString *) newUniqueIDString];
    
    CFRelease(newUniqueID);
    CFRelease(newUniqueIDString);
    
    image = [self resizeImage:image];
    
    [[ImageCache sharedImageCache] setImage:image forKey:[newPuzzle imageKey]];
    
    [imageView setImage:image];
    
//    [newPuzzle setThumbnailDataFromImage:image];
//    [newPuzzle setImageData:image];
    
    //puzzleImage = image;
    
    instructionLabel.hidden = YES;
    
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction) sliderValueChanged:(id)sender
{
    piecesLabel.text = [NSString stringWithFormat:@"%.0f x %.0f",piecesSlider.value, piecesSlider.value];
}


- (IBAction) savePuzzle:(id)sender
{
    
    newPuzzle.numPieces = (int) piecesSlider.value;
    newPuzzle.puzzleName = nameTextField.text;
    
    [delegate receivePuzzle:newPuzzle];
    
    //[self dismissModalViewControllerAnimated:YES];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
