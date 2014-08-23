//
//  HighscoreViewController.m
//  Hackathon2014
//
//Copyright (c) <2014>, <ITCC Liechtenstein>
//All rights reserved.
//
//Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//
//2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "HighscoreViewController.h"

@interface HighscoreViewController ()
{

}
@property (nonatomic, strong) NSString *leaderboardIdentifier;
@property (nonatomic) BOOL gameCenterEnabled;
@property (nonatomic) BOOL newHighscore;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger highscore;

- (void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;
- (void)authenticateLocalPlayer;
- (void)reportScore;
- (void)loadScores;

@end

@implementation HighscoreViewController
@synthesize currScore, highScore;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _newHighscore = NO;
    [self authenticateLocalPlayer];
    [[NSUserDefaults standardUserDefaults] setInteger:100 forKey:@"score"]; // Test
    [self loadScores];
    
    [self reportScore];
    
    if (_gameCenterEnabled) {
        [self showLeaderboardAndAchievements:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)loadScores {
    _score = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];
    _highscore = [[NSUserDefaults standardUserDefaults] integerForKey:@"score"];

    if (_score > _highscore) {
        [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"highscore"];
        _highscore = _score;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)authenticateLocalPlayer {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        } else {
            if ([GKLocalPlayer localPlayer].authenticated) {
                _gameCenterEnabled = YES;
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    } else {
                        _leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            } else {
                _gameCenterEnabled = NO;
            }
        }
    };
}
- (void)reportScore {
    currScore.text = [NSString stringWithFormat:@"Sie haben %li Punkte erreicht", (long)_score];
    if (_newHighscore) {
        highScore.text = [NSString stringWithFormat:@"Neuer Highscore: %li", (long)_highscore];
    } else {
        highScore.text = [NSString stringWithFormat:@"Alter Highscore: %li", (long)_highscore];
    }
    if (_gameCenterEnabled) {
        GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:_leaderboardIdentifier];
        score.value = _score;
        
        [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
        }];
    }
}
- (void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard {
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = _leaderboardIdentifier;
    } else {
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    [self presentViewController:gcViewController animated:YES completion:nil];
}
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showGamecenter:(id)sender {
    if (!_gameCenterEnabled){
        [self authenticateLocalPlayer];
}
    [self showLeaderboardAndAchievements:YES];
}
@end
