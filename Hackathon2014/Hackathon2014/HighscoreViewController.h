//
//  HighscoreViewController.h
//  Hackathon2014
//
//  Created by Swiss App Innovation on 22.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface HighscoreViewController : UIViewController <GKGameCenterControllerDelegate>
- (IBAction)showGamecenter:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *currScore;
@property (weak, nonatomic) IBOutlet UILabel *highScore;

@end
