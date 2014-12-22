//
//  CActivityViewController.h
//  Contacts
//
//  Created by Ranjith on 17/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CActivityViewController : UIViewController<UIActivityItemSource>
@property (strong, nonatomic) NSURL *url;
- (instancetype)initWithURL:(NSURL *)url;
@end
