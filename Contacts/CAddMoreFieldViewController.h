//
//  CAddMoreFieldViewController.h
//  Contacts
//
//  Created by Ranjith on 17/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAddress.h"

@interface CAddMoreFieldViewController : UIViewController

@property(nonatomic,strong)NSString *contactObjectId;
@property(nonatomic,strong)CAddress *address;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlProperty;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *districtTextField;

@end
