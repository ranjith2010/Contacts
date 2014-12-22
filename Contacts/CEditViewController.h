//
//  CEditViewController.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CContact.h"
#import "CAddress.h"

@interface CEditViewController : UIViewController{
        IBOutlet UIScrollView *scroller;
}
@property(nonatomic,strong)CContact *contact;
@property(nonatomic,strong)CAddress *address;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *districtTextField;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtnProperty;
@end
