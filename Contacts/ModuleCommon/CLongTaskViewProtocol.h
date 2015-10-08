//
//  CLongTaskViewProtocol.h
//  Contacts
//
//  Created by Srikanth on 11/09/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CAlertActionBlock)(void);
typedef void (^CAlertIndexedActionBlock)(NSInteger buttonIndex);

@protocol CLongTaskViewProtocol <NSObject>
@required
/*!
 Show busy indicator. The type of busy indicator is upto the View.
 @param message The text message (example "Loading...", "Please wait..."). This can be nil.
 @param image The image to be shown as part of busy indicator. This is optional and can be used if the View supports. This can be nil.
 */
- (void)showBusyIndicatorWithMessage:(NSString*)message andImage:(UIImage*)image;

/*!
 Dismisses busy indicator
 */
- (void)dismissBusyIndicator;

/*!
 Shows an error as an alert. The presentation style is upto the view.
 @param error The reason error. The message of the alert is the localizedDescription of the error.
 @param title The alert title. This can be nil.
 @param positiveButtonTitle The text for positive action button.
 @param negativeButtonTitle The text for negative action button.
 @param positiveBlock The block to be executed when user responds with positive action.
 @param negativeBlock The block to be executed when user responds with negative action. This can be nil.
 */
- (void)showError:(NSError*)error
        withTitle:(NSString*)title
positiveButtonTitle:(NSString*)positiveTitle
negativeButtonTitle:(NSString*)negativeTitle
    positiveBlock:(CAlertActionBlock)positiveBlock
    negativeBlock:(CAlertActionBlock)negativeBlock;


/*!
 Shows a confirmation dialog. The presentation style is upto the view.
 @param title The alert title. This can be nil.
 @param message The alert message.
 @param positiveButtonTitle The text for positive action button.
 @param negativeButtonTitle The text for negative action button.
 @param positiveBlock The block to be executed when user responds with positive action.
 @param negativeBlock The block to be executed when user responds with negative action. This can be nil.
 */
- (void)showConfirmationWithTitle:(NSString*)title
                          message:(NSString*)message
              positiveButtonTitle:(NSString*)positiveTitle
              negativeButtonTitle:(NSString*)negativeTitle
                    positiveBlock:(CAlertActionBlock)positiveBlock
                    negativeBlock:(CAlertActionBlock)negativeBlock;

/*!
 Shows an information to the User. This is called in a situations where the system presents some info to the user but does not depend on the user's action. For example an invalid email during signup.
 @param title The info title. This can be nil.
 @param message The info message.
 @param dismissButtonTitle The dismiss button title.
 */
- (void)showInformationWithTitle:(NSString*)title
                         message:(NSString*)message
              dismissButtonTitle:(NSString*)dismissTitle;

/*!
 Shows a confirmation dialog with more then one positive buttons. The presentation style is upto the view.
 @param message The alert message.
 @param title The alert title. This can be nil.
 @param positiveTitles The text for positive action buttons in array.
 @param negativeTitle The text for negative action button.
 @param dismissBlock The block to be executed when user responds with positive action and gives back the selected positive button index.
 @param negativeBlock The block to be executed when user responds with negative action. This can be nil.
 */
- (void)showMessage:(NSString*)message
          withTitle:(NSString*)title
     positiveTitles:(NSArray*)positiveTitles
      negativeTitle:(NSString*)negativeTitle
      positiveBlock:(CAlertIndexedActionBlock)dismissBlock
      negativeBlock:(CAlertActionBlock)cancelBlock;

/*!
 Shows a Notification to the User. This is called in a situations where the user Received a New notification
 @param message This is a Notification message
 */
- (void)showToastWithMessage:(NSString*)message;

@end