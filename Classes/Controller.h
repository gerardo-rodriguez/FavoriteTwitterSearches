//
//  Controller.h
//  FavoriteTwitterSearches
//
//  Created by Gerardo Rodriguez on 11/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants that control the height of the buttons and the spacing
#define BUTTON_SPACING 10
#define BUTTON_HEIGHT 40

@interface Controller : NSObject {
	// Interface Builder outlets
	IBOutlet UIScrollView *scrollView; // for scrollable favorites
	IBOutlet UITextField *tagField; // text field for entering tag
	IBOutlet UITextField *queryField; // text field for entering query
	
	// stores the tag names and searches
	NSMutableDictionary *tags;
	
	// stores the Buttons representing the searches
	NSMutableArray *buttons;
	
	// stores the info buttons for editing existing searches
	NSMutableArray *infoButtons;
	
	// location of the file in which favorites are stored
	NSString *filePath;
}

- (IBAction)addTag:sender; // adds a new tag
- (IBAction)clearTags:sender; // clears all of the tagsj
- (void)addNewButtonWithTitle:(NSString *)title; // creates a new button
- (void)refreshList; // refreshes the list of buttons
- (void)buttonTouched:sender; // handles favorite button event
- (void)infoButtonTouched:sender; // handles info button event
@end

// begin UIButton's sorting category
@interface UIButton (sorting)
	// compares this UIButton's title to the given UIButton's title
	- (NSComparisonResult)compareButtonTitles:(UIButton *)button;
@end