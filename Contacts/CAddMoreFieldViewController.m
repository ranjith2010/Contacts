//
//  CAddMoreFieldViewController.m
//  Contacts
//
//  Created by Ranjith on 17/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CAddMoreFieldViewController.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CLocal.h"
#import "CLocalInterface.h"

@interface CAddMoreFieldViewController ()

@end

@implementation CAddMoreFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)dismissKeyboard:(id)sender {
}


- (IBAction)doneBtn:(id)sender {
    if(_address){
        [self pr_loadUiValues];
        [self pr_editAddress];
    }
    else{
        _address = [[CAddress alloc]init];
        [self pr_loadUiValues];
        [self pr_addNewAddress];
    }
}

- (void)pr_loadUiValues{
    [_address setTypeOfAddress:[self.segmentControlProperty titleForSegmentAtIndex:[self.segmentControlProperty selectedSegmentIndex]]];
    [_address setStreet:_streetTextField.text];
    [_address setDistrict:_districtTextField.text];
}
- (void)pr_editAddress{
    [[CServer defaultParser] editAddress:_address :^(BOOL succeed){
        if(succeed){
            [[CLocal defaultLocalDB] editAddress:_address :^(BOOL succeed){
                if(succeed){
                    NSLog(@"Hopefully Edited.");
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
    }];
}

- (void)pr_addNewAddress{
    [_address setAddressId:[[[CServer defaultParser] randomIdFromNSUserDefault] intValue]];
    [_address setContactObjectId:_contactObjectId];
    [[CServer defaultParser] saveAddress:_address :^(BOOL succeed){
        if(succeed){
            [[CServer defaultParser] affectAddressIdinContact :_contactObjectId withAddressId
                                                             :_address.addressId
                                                             :^(BOOL succeed){
                                                            if(succeed){
                                                            [[CLocal defaultLocalDB] saveAddress:_address
                                                                                                :^(BOOL succeed){
                                                            if(succeed){
                                                            [[CLocal defaultLocalDB] affectAddressIdinContact:_contactObjectId withAddressId:_address.addressId :^(BOOL succeed){
                                                                    if(succeed){
                                                                    NSLog(@"Hopefully added new Address");
                                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                                                 }
                                                                             }];
                                                                         }
                                                                     }];
                                                                 }
                                                             }];
                                                        }
                                                }];
}


- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
