//
//  CActivityViewController.m
//  Contacts
//
//  Created by Ranjith on 17/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CActivityViewController.h"

@interface CActivityViewController ()

@end

@implementation CActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        _url = url;
    }
    return self;
}


#pragma mark - UIActivityItemSource

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController{
    //Because the URL is already set it can be the placeholder. The API will use this to determine that an object of class type NSURL will be sent.
    return self.url;
}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType{
    //Return the URL being used. This URL has a custom scheme (see ReadMe.txt and Info.plist for more information about registering a custom URL scheme).
    return self.url;
}

- (UIImage *)activityViewController:(UIActivityViewController *)activityViewController thumbnailImageForActivityType:(NSString *)activityType suggestedSize:(CGSize)size{
    //Add image to improve the look of the alert received on the other side, make sure it is scaled to the suggested size.
    //return [UIImage imageWithImage:[UIImage imageNamed:kCustomURLImageName] scaledToFitToSize:size];
    return  nil;
}
@end
