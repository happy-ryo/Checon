//
// Created by happy_ryo on 2013/12/23.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Kiwi.h"
#import "FacebookPermissions.h"

SPEC_BEGIN(FacebookPermissionsSpec)

        describe(@"Permissions", ^{
            it(@"Check permission count == 2.", ^{
                FacebookPermissions *permissions = [[FacebookPermissions alloc] init];
                [[[permissions.permissions should] haveAtLeast:2] items];
            });
            it(@"Check permission.", ^{
                FacebookPermissions *permissions = [[FacebookPermissions alloc] init];
                if (![permissions.permissions containsObject:@"user_checkins"]) {
                    fail(@"not user checkins");
                }

                if (![permissions.permissions containsObject:@"publish_checkins"]) {
                    fail(@"not publish checkins");
                }
            });
        });

        SPEC_END
