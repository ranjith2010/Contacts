//
//  CAddressBookEngine.m
//  Contacts
//
//  Created by ranjit on 10/08/15.
//  Copyright © 2015 Zippr. All rights reserved.
//

#import "CAddressBookEngine.h"
#import <AddressBook/AddressBook.h>
#import "ZPContactModel.h"
#import "NSString+Additions.h"

@implementation CAddressBookEngine

+ (CAddressBookEngine*)sharedInstance {
    static CAddressBookEngine* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[CAddressBookEngine alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    return self;
}

#pragma mark - Protocol implementations.

- (void)authorization:(void (^)(AddressBookAuthorization status))block
{
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        CFErrorRef error = NULL;
        ABAddressBookRef myAddressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABAddressBookRequestAccessWithCompletion(myAddressBook,
            ^(bool granted, CFErrorRef error) {
                if (granted) {
                    block(ABAuthorizationStatusAuthorized);
                }
                else {
                    // Handle the case of being denied access and/or the error.
                    block(ABAuthorizationStatusDenied);
                }
                CFRelease(myAddressBook);
            });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // The user has previously given access, add the contact
        block(ABAuthorizationStatusAuthorized);
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
        // The user has previously denied access
        // Send an alert telling user to change privacy setting in settings app
        block(ABAuthorizationStatusDenied);
    }
}

- (void)saveContact {

}
- (void)updateContact {

}
- (void)deleteContact {

}
- (void)fetchContacts:(void(^)(NSArray *ABObjects))block {
    NSMutableArray *contacts = [[NSMutableArray alloc]init];
    CFErrorRef error = NULL;
    ABAddressBookRef myAddressBook = ABAddressBookCreateWithOptions(NULL, &error);
    CFArrayRef people = (ABAddressBookCopyArrayOfAllPeople(myAddressBook));
    CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(kCFAllocatorDefault, CFArrayGetCount(people),people);
    CFArraySortValues(peopleMutable,
                      CFRangeMake(0, CFArrayGetCount(peopleMutable)),
                      (CFComparatorFunction) ABPersonComparePeopleByName,
                      kABPersonSortByFirstName);

    CFRelease(people);
    for (CFIndex i = 0; i < CFArrayGetCount(peopleMutable); i++){
        ABRecordRef record = CFArrayGetValueAtIndex(peopleMutable, i);
        ZPContactModel *contact =[self iterateAllFieldsOfContact:record];
        if(contact) {
            [contacts addObject:contact];
        }
    }
    CFRelease(peopleMutable);
    block(contacts);
}


- (ZPContactModel*)iterateAllFieldsOfContact:(ABRecordRef)person {
    // Use a general Core Foundation object.
    CFTypeRef generalCFObject = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ZPContactModel *contact = [[ZPContactModel alloc]init];
    // Get the first name.
    if (generalCFObject) {
        [contact setFirstname:(__bridge NSString*)generalCFObject];
        CFRelease(generalCFObject);
    }

    // Get the last name.
    generalCFObject = ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (generalCFObject) {
        [contact setLastname:(__bridge NSString*)generalCFObject];
        CFRelease(generalCFObject);
    }

    // Get the phone numbers as a multi-value property.
    NSMutableArray *phoneCollection = [[NSMutableArray alloc]init];
    ABMutableMultiValueRef phonesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phonesRef) > 0) {
        for (int i=0; i<ABMultiValueGetCount(phonesRef); i++) {
            CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
            NSString *phone = (__bridge NSString *)currentPhoneValue;
            [phoneCollection addObject:[phone c_removeSymbols]];
            CFRelease(currentPhoneValue);
        }
        [contact setPhone:phoneCollection];
        CFRelease(phonesRef);
    }

    // Get the e-mail addresses as a multi-value property.
    NSMutableArray *emailCollection = [[NSMutableArray alloc]init];
    ABMutableMultiValueRef emailsRef = ABRecordCopyValue(person, kABPersonEmailProperty);
    if(ABMultiValueGetCount(emailsRef) > 0) {
        for (int i=0; i<ABMultiValueGetCount(emailsRef); i++) {
            CFStringRef currentEmailValue = ABMultiValueCopyValueAtIndex(emailsRef, i);
            NSString *email = (__bridge NSString *)currentEmailValue;
            [emailCollection addObject:email];
            CFRelease(currentEmailValue);
        }
        [contact setEmail:emailCollection];
        CFRelease(emailsRef);
    }
    if (emailCollection.count || phoneCollection.count) {
        return contact;
    }
    return nil;
}


@end
