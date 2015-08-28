//
//  CSignUpViewController.h
//  Contacts
//
//  Created by ranjit on 20/07/15.
//  Copyright (c) 2015 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol dismiss <NSObject>

- (void)dismissRegisterVC;

@end


@interface CSignUpViewController : UIViewController

@property (nonatomic)id<dismiss>delegate;

@end
