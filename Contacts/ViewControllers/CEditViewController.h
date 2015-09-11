//
//  CEditViewController.h
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CContact.h"

@protocol pop <NSObject>

- (void)popout;

@end

@interface CEditViewController : UIViewController

@property(nonatomic,strong)CContact *contact;

@property (nonatomic)id<pop>delegate;

@end
