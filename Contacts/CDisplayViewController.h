//
//  CDisplayViewController.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CContact.h"
#import "CActivityViewController.h"

@interface CDisplayViewController : UIViewController<UIActionSheetDelegate>{
    IBOutlet UIScrollView *scroller;
}

@property(nonatomic,strong)NSMutableArray *allContacts;
@property(nonatomic,strong)CContact *contact;
@property(strong,nonatomic)CActivityViewController *activityVC;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
@end
