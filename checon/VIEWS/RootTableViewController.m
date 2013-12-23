//  Copyright 2013 happy_ryo

#import <Parse/Parse.h>
#import <Parse/PFFacebookUtils.h>
#import "RootTableViewController.h"

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
        FBSession *fbSession = [PFFacebookUtils session];
        __weak RootTableViewController *weakSelf = self;
        if (!fbSession.isOpen) {
            [fbSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                if (status == FBSessionStateOpen) {

                } else {
                    [weakSelf openLoginForm];
                }
            }];
        }
    } else {
        [self openLoginForm];
    }
}


- (void)openLoginForm {
    [self performSegueWithIdentifier:kFBLogin sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
}

@end