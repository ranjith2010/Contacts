//
//  CBaseTableViewController.h
//  Contacts
//
//  Created by Srikanth on 08/10/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLongTaskViewHelper.h"

@interface UITableView (emptyCell)
- (void)reloadDataWithHideEmptyCell;
@end
/*!
 The base table view controller. All table view controllers should be extending from this.
 This provides the default implementation of CLongTaskViewProtocol.
 */
@interface CBaseTableViewController : UITableViewController <CLongTaskViewProtocol>
@property (nonatomic, readonly) CLongTaskViewHelper* viewHelper;
@end
