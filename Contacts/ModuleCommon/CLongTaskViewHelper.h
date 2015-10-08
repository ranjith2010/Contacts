//
//  CLongTaskViewHelper.h
//  Contacts
//
//  Created by Srikanth on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLongTaskViewProtocol.h"

@interface CLongTaskViewHelper : NSObject <CLongTaskViewProtocol>

/*!
 Designated initializer.
 @param viewController The view controller for which requires implementation of CLongTaskViewProtocol
 */
- (instancetype)initWithContainerViewController:(UIViewController*)viewController;

/*!
 Conainer view in which busy indicators are presented.
 */
@property (nonatomic, readwrite, weak) UIView* containerView;

@end
