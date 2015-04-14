//
//  PUSelectionTableViewController.h
//  ParseUser
//
//  Created by Ranjith on 25/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CActivityViewController.h"

@interface CSelectionTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray *contacts;
@property(strong,nonatomic)CActivityViewController *activityVC;

@end
