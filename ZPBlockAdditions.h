//
//  ZPBlockAdditions.h
//  Zipper Beta 2
//
//  Created by Ashish on 09/10/13.
//  Copyright (c) 2013 Ashish. All rights reserved.
//

/*
 File: ZPBlockAdditions.h
 Abstract: This is a header file of UIAlertView+ZPBlockAdditions, that defines different types of blocks used.
 */

#ifndef Zipper_Beta_2_ZPBlockAdditions_h
#define Zipper_Beta_2_ZPBlockAdditions_h


typedef void (^VoidBlock)();

typedef void (^ZPAlertIndexedActionBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();

typedef void(^ZPAlertActionBlock)(void);
typedef void (^ZPAlertIndexedActionBlock)(NSInteger buttonIndex);


#endif
