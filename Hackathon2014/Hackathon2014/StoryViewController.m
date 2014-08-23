//
//  StoryViewController.m
//  Hackathon2014
//
//  Created by Elwin on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "StoryViewController.h"

static NSString * const kCurrentView = @"currentStory";

@interface StoryViewController ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *stories;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end

@implementation StoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadData];
	[[NSUserDefaults standardUserDefaults] setValue:@0 forKey:kCurrentView];
	[self assignData];
	[self.view setBackgroundColor:[UIColor colorWithRed:0.898 green:0.941 blue:0.952 alpha:1]];
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self.progressBar setTintColor:[UIColor colorWithRed:0.078 green:0.447 blue:0.576 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma - data handling

- (void)assignData {
	NSInteger currentView = [[[NSUserDefaults standardUserDefaults] valueForKey:kCurrentView] integerValue];
	self.stories = self.array[0];

	if (currentView == 0) {
		self.backButton.enabled = false;
	}
	if (currentView == ([self.stories count] - 1)) {
		self.nextButton.enabled = false;
	}
	
	if (currentView > 0) {
		self.backButton.enabled = true;
	}
	if (currentView < ([self.stories count] - 1)) {
		self.nextButton.enabled = true;
	}
	
	if (((currentView + 1) <= [self.stories count]) && (currentView >= 0)) {
		
		NSDictionary *story = self.stories[currentView];
		
		self.titleLabel.textColor = [UIColor colorWithRed:0.078 green:0.447 blue:0.576 alpha:1];
		self.titleLabel.text = [story valueForKey:kTitleKey];
		self.textView.textColor = [UIColor colorWithRed:0.454 green:0.674 blue:0.749 alpha:1];
		self.textView.text = [story valueForKey:kBodyKey];
        NSNumber *number = [NSNumber numberWithInteger:[self.stories count]];
		float total = [number floatValue];
		float progress = ((currentView + 1) / total);
		[self.progressBar setProgress:progress animated:YES];
        self.title = [story valueForKey:kTitleKey];
	} else
		NSLog(@"Out of bounds");
}

- (void)loadData {
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		self.array = [[NSArray alloc] initWithContentsOfFile:filePath];
	} else {
		NSLog(@"No file found!");
	}
}

- (IBAction)nextButton:(id)sender {
	NSInteger currentView = [[[NSUserDefaults standardUserDefaults] valueForKey:kCurrentView] integerValue] + 1;
	if (currentView >= [self.stories count]) {
		currentView--;
	}
	[[NSUserDefaults standardUserDefaults] setInteger:currentView forKey:kCurrentView];
	[self assignData];
}

- (IBAction)backButton:(id)sender {
	NSInteger currentView = [[[NSUserDefaults standardUserDefaults] valueForKey:kCurrentView] integerValue] - 1;
	if (currentView < 0) {
		currentView++;
	}
	[[NSUserDefaults standardUserDefaults] setInteger:currentView forKey:kCurrentView];
	[self assignData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
