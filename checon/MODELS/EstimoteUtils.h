//
// Created by happy_ryo on 2013/12/24.
//
// To change the template use AppCode | Preferences | File Templates.
//
#import <Foundation/Foundation.h>
#import "ESTBeaconManager.h"


static NSString *const kRegionIdentifier = @"Checon";

static NSString *const kProximityUUID = @"proximity_uuid";

static NSString *const kEstimoteList = @"EstimoteList";

static NSString *const kMajor = @"major";

static NSString *const kMinor = @"minor";

@interface EstimoteUtils : NSObject <ESTBeaconManagerDelegate>
- (instancetype)initWithEstimoteCallback:(void (^)(NSArray *))aEstimoteCallback;

@end