//
//  CBaseViewController.h
//  Contacts
//
//  Created by Srikanth on 08/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

/*!
 The base view controller. All view controllers should be extending from this.
 This provides the default implementation of ZPLongTaskViewProtocol.
 This also helps to isolate busy indicator, UI alerts so that they can be changed or replaced with new implementation.
 This provides basic implementation for automatic keyboard handling so that views are not
 obscured with keyboard.
 */
#import <UIKit/UIKit.h>
#import "CLongTaskViewHelper.h"

@interface CBaseViewController : UIViewController <CLongTaskViewProtocol>

/*!
 The view helper which provides the implementation of ZPLongTaskViewProtocol.
 */
@property (nonatomic, readonly) CLongTaskViewHelper* viewHelper;

/*!
 Registers for keyboard notifications. Recommended to call from viewWillAppear.
 @param target The target object.
 @param selectorForWillShow The selector to be invoked when keyboard will show.
 @param selectorForWillShow The selector to be invoked when keyboard will hide.
 */
- (void)registerForKeyboardNotifications:(id)target
                     selectorForWillShow:(SEL)willShowSelector
                     selectorForWillHide:(SEL)willHideSelector;

/*!
 Deregister from keyboard notifications. Recommended to call from viewWillDissapear.
 @param target The target earlier registered with keyboard notifications.
 */
- (void)deregisterFromKeyboardNotifications:(id)target;

/*!
 Provides automatic keyboard handling. This moves the view frame so that it is not obscured by keyboard.
 Registering and deregistering is not required when using this method.
 @param provide If YES automatically handles keyboard. If NO stops automatic handling.
 */
- (void)provideAutomaticKeyboardHanlding:(BOOL)provide;

/*!
 Same as provideAutomaticKeyboardHanlding:
 In addition dismisses the keyboard on responder's UIControlEventEditingDidEndOnExit event.
 @param provide If YES automatically handles keyboard. If NO stops automatic handling.
 @param responder The textfield which can have keyboard focus.
 */
- (void)provideAutomaticKeyboardHanlding:(BOOL)provide
                           onUIResponder:(UIControl*)responder;

/*!
 @return whether id automatically handling keyboard.
 */
- (BOOL)isProvidingAutomaticKeyboardHanding;
@end