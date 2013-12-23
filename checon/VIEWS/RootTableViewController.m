//  Copyright 2013 happy_ryo

#import <Parse/Parse.h>
#import <Parse/PFFacebookUtils.h>
#import "RootTableViewController.h"
#import "FacebookPermissions.h"

@interface RootTableViewController ()
- (void)openLoginForm;
@end

@implementation RootTableViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [PFFacebookUtils reauthorizeUser:[PFUser currentUser]
                  withPublishPermissions:[[FacebookPermissions alloc] init].permissions
                                audience:FBSessionDefaultAudienceFriends
                                   block:^(BOOL succeeded, NSError *error) {
                                       if (succeeded) {
                                           NSLog(@"Suc");
                                       } else {
                                           [self openLoginForm];
                                       }
                                   }];
    } else {
        [self openLoginForm];
    }
}


- (void)openLoginForm {
    [self performSegueWithIdentifier:@"FBLogin" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
}

@end