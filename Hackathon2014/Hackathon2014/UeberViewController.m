//
//  UeberViewController.m
//  Hackathon2014
//
//  Created by Simon on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "UeberViewController.h"

@interface UeberViewController ()

@end

@implementation UeberViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tableView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
 
     if (indexPath.row == 0) {
         cell.textLabel.text = @"ITCC auf Twitter";
     } else if (indexPath.row == 1) {
         cell.textLabel.text = @"ITCC im Internet";
     } else if (indexPath.row == 2) {
         cell.textLabel.text = @"ITCC auf Facebook";
     }
 
 return cell;
 }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSLog(@"Row 0");
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://itcc"]];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/itcc"]];
            
        }
    }
    else if(indexPath.row == 1) {
        NSLog(@"Row 1");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hackathon.li"]];
    }
    else if(indexPath.row == 2) {
        NSLog(@"Row 2");
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://itcc.li"]];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/itcc.li"]];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
