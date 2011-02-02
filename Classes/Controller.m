//
//  Controller.m
//  FavoriteTwitterSearches
//
//  Created by Gerardo Rodriguez on 11/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"


@implementation Controller

//called when object is initialized
- (id)init
{
	self = [super init]; // initialize the superclass members
	
	if (self != nil) // if the superclass initialized properly
	{
		// creates list of valid directories for saving a file
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		
		// get the first directory
		NSString *dir = [paths objectAtIndex:0];
		
		// concatenate the file name "tasIndex.plist" to the path
		filePath = [[NSString alloc] initWithString:[dir stringByAppendingPathComponent:@"tagsIndex.plist"]];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		// if the file does not exist, create an empty NSMutableDirectory;
		// otherwise, intiailize an NSDictionary with the file's contents
		if ([fileManager fileExistsAtPath:filePath] == NO) 
		{
			tags = [[NSMutableDirectory alloc] init];
		}
		else 
		{
			tags = [[NSMutableDirectory alloc] initWithContentsOfFile:filePath];
		}
		
		buttons = [[NSMutableArray alloc] init]; // create array
		infoButtons = [[NSMutableArray alloc] init]; // create array
	}
	
	return self;
}

// called when the GUI components finish loading
- (void)awakeFromNib
{
	for (NSString *title in tags) {
		[self addNewButtonWithTitle:title];
	}
}

// remove all buttons and populate View with favorites
- (void)refreshList
{
	// remove all the buttons from the GUI
	for (UIButton *button in scrollView.subviews) {
		[button removeFromSuperview];
	}
	
	[infoButtons removeAllObjects];
	
	float buttonOffset = BUTTON_SPACING; // reset the spacing
	
	// repopulate the scroll view with buttons
	for (UIButton *button in buttons) {
		CGRect buttonFrame = button.frame; // fetch the frame of button
		buttonFrame.origin.x = BUTTON_SPACING; // set the x-coordinate
		buttonFrame.origin.y = buttonOffset; // set the y-coordinate

		// button width is the size of the view minus padding on each side
		buttonFrame.size.width = scrollView.frame.size.width - 5 * BUTTON_SPACING;
		buttonFrame.size.height = BUTTON_HEIGHT; // set the height of button
		button.frame = buttonFreame; // assign the new frame to the button
		[scrollView addSubview:button]; // add button as a subview
		
		// create detail button
		UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[infoButtons addObject:infoButton]; // add infoButton to infoButtons
		
		// position button to the right of the button we just added
		buttonFrame = infoButton.frame; // fetch the frame of infoButton
		buttonFrame.origin.x = scrollView.frame.size.width - 35;
		
		// this button is a bit shorter than normal buttons, so we adjust
		buttonFrame.origin.y = buttonOffset +3;
		infoButton.frame = buttonFrame; // assign the new frame
		
		// make the button call infoButtonTouched: when it is touched
		[infoButton addTarget:self action:@selector(infoButtonTouched:) forControlEvents:UIControlEventTouchInside];
		[scrollView addSubview:infoButton]; // add infoButton as a subview
		
		// increase the offset so the next button is added further down
		buttonOffset += BUTTON_HEIGHT + BUTTON_SPACING;
	}
}

// called when the user touches an info button
- (void)infoButtonTouched:sender
{
	// get the index of the button that was touched
	int index = [infoButtons indexOfObject:sender];
	
	// get the title of the button
	NSString *key = [[buttons objectAtIndex:index] titleLabel].text;
	tagField.text = key; // update tagField with the button title
	
	// get the search query using the button title
	NSString *value = [tags valueForKey:key];
	queryField.text = value; // update queryField with the value
}



@end
