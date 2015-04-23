//
//  CEditViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CEditViewController.h"

#import "CLocal.h"
#import "CLocalInterface.h"

#import "CServer.h"
#import "CServerInterface.h"

@interface CEditViewController ()

@end

@implementation CEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.scrollView setScrollEnabled:YES];
    //[scroller setContentSize:CGSizeMake(320, 800)];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:0
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:0];
    
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTrailing relatedBy:0 toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:rightConstraint];

    [self initialDataSetup];
}

#pragma mark - Private API

- (void)initialDataSetup{
    if(_contact){
        _nameTextField.text = _contact.name;
        _emailTextField.text = _contact.email;
        _mobileTextField.text = _contact.phone;
        [[CLocal defaultLocalDB] fetchAddress:[[_contact.addressIdCollection firstObject] intValue]
                                             :^(CAddress *address){
                                                 if(address){
                                                     _typeTextField.text = address.typeOfAddress;
                                                     _streetTextField.text = address.street;
                                                     _districtTextField.text = address.district;
                                                 }
                                             }];
                                        }
}


- (IBAction)doneBtn:(id)sender {
    if([_nameTextField.text isEqualToString:@""]){
            UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Don't go with Emptie name" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [errorAlert show];
    }
    else if(!_contact){
    [self pr_createNewContact];
    }
    else{
        _contact.name = _nameTextField.text;
        _contact.phone = _mobileTextField.text;
        _contact.email = _emailTextField.text;
        _address  = [[CAddress alloc]init];
        _address.addressId = [[_contact.addressIdCollection firstObject] intValue];
        _address.typeOfAddress = _typeTextField.text;
        _address.street = _streetTextField.text;
        _address.district = _districtTextField.text;
        [self pr_updateExistingContact];
    }
}

// Its for Apply #New changes to exisiting Contact And Address @Parse @CoreData
- (void)pr_updateExistingContact{
    [[CServer defaultParser] editContact:_contact :^(BOOL succeed){
        if(succeed){
            [[CLocal defaultLocalDB] editContact:_contact :^(BOOL succeed){
                if(succeed && _address){
                    [[CServer defaultParser] editAddress:_address :^(BOOL succeed){
                        if(succeed){
                            [[CLocal defaultLocalDB] editAddress:_address :^(BOOL succeed){
                                if(succeed){
                                    NSLog(@"Everything Updated @parse & @Coredata");
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


// Its not belongs to Edit #Option. its for creating new Contact @Parse @CoreData
- (void)pr_createNewContact{
        _contact = nil;
        _contact = [[CContact alloc]init];
        [_contact setName:_nameTextField.text];
        [_contact setEmail:_emailTextField.text];
        [_contact setPhone:_mobileTextField.text];
        [[CServer defaultParser] currentUserObjectId:^(NSString *objectId){
            if(objectId){
                [_contact setUserObjectId:objectId];
                CAddress *address = [[CAddress alloc]init];
                [address setTypeOfAddress:_typeTextField.text];
                [address setStreet:_streetTextField.text];
                [address setDistrict:_districtTextField.text];
                [address setAddressId:[[[CServer defaultParser] randomIdFromNSUserDefault] intValue]];
                [[CServer defaultParser] saveContact:_contact :^(BOOL succeed){
                    if(succeed){
                        _contact.addressIdCollection = [[NSMutableArray alloc]init];
                        [_contact.addressIdCollection addObject:[NSNumber numberWithInt:address.addressId]];
                        [[CServer defaultParser] updateContact:_contact :^(CContact *contact){
                            if(contact){
                        [address setContactObjectId:contact.objectId];
                                // Here i need to set the CDContact to Address.CDContact.????
                                // If i do here - I can't full fill the Factory Pattern
                        [[CServer defaultParser] saveAddress:address :^(BOOL succeed){
                            if(succeed){
                                [[CLocal defaultLocalDB] saveContact:contact :^(BOOL succeed){
                                        if(succeed){
                                            [[CLocal defaultLocalDB]saveAddress:address :^(BOOL succeed){
                                                    if(succeed){
                                                        NSLog(@"All those #CoreData Works has been done!");
                                                        _nameTextField.text = @"";
                                                        _emailTextField.text = @"";
                                                        _mobileTextField.text = @"";
                                                        _typeTextField.text = @"";
                                                        _streetTextField.text = @"";
                                                        _districtTextField.text = @"";
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
                }];
            }
        }];
}

- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissKeyboard:(id)sender {
}

@end
