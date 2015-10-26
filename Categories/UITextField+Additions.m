//
//  UITextField+Additions.m
//  Contacts
//
//  Created by ranjith on 26/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "UITextField+Additions.h"

@implementation UITextField (Additions)


- (void)CAddBorderColor {
    self.layer.borderColor=[[UIColor blackColor]CGColor];
    self.layer.borderWidth=1.0;
    self.layer.masksToBounds=YES;
}

- (void)CRevertBorderColor {
    self.layer.borderColor =[[UIColor clearColor]CGColor];
    self.layer.masksToBounds=YES;
}

@end
