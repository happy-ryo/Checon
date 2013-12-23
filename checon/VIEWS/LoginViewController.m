//
// Created by happy_ryo on 2013/12/23.
//
// To change the template use AppCode | Preferences | File Templates.
//
#import <Parse/Parse.h>
#import <Parse/PFFacebookUtils.h>
#import "LoginViewController.h"
#import "FacebookPermissions.h"


@interface LoginViewController ()
- (void)message:(NSString *)message;
@end

@implementation LoginViewController {

}

- (IBAction)fbLogin {
    [PFFacebookUtils logInWithPermissions:[[FacebookPermissions alloc] init].permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            [self message:@"ログインに失敗しました"];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Checon" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
@end