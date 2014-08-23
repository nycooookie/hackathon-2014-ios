//
//  UeberViewController.h
//  Hackathon2014
//
//  Created by Simon on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UeberViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
