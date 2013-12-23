//
// Created by happy_ryo on 2013/12/24.
//
// To change the template use AppCode | Preferences | File Templates.
//
#import <Parse/Parse.h>
#import "EstimoteUtils.h"
#import "ESTBeaconManager.h"

@implementation EstimoteUtils {
    ESTBeaconManager *_estBeaconManager;
    NSArray *_beacons;

    void (^EstimoteCallback)(NSArray *array);
}

- (id)init {
    self = [super init];
    if (self) {
        _beacons = @[];
        _estBeaconManager = [[ESTBeaconManager alloc] init];
        _estBeaconManager.delegate = self;
        ESTBeaconRegion *region = [[ESTBeaconRegion alloc] initRegionWithIdentifier:kRegionIdentifier];
        [_estBeaconManager startRangingBeaconsInRegion:region];
    }

    return self;
}

- (instancetype)initWithEstimoteCallback:(void (^)(NSArray *))aEstimoteCallback {
    self = [self init];
    if (self) {
        EstimoteCallback = aEstimoteCallback;
    }

    return self;
}


- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region {
    if ([self checkRangeBeaconVariation:beacons]) {
        _beacons = beacons;
        [self estimoteListRetriever];
    }
}

- (BOOL)checkRangeBeaconVariation:(NSArray *)array {

    for (ESTBeacon *newBeacon in array) {
        BOOL exist = NO;
        for (ESTBeacon *oldBeacon in _beacons) {
            if ([newBeacon.proximityUUID.UUIDString isEqualToString:oldBeacon.proximityUUID.UUIDString] &&
                    newBeacon.major == oldBeacon.major &&
                    newBeacon.minor == oldBeacon.minor) {
                exist = YES;
            }
        }
        if (exist == NO) return YES;
    }

    return NO;
}

- (void)estimoteListRetriever {
    PFQuery *query = [PFQuery queryWithClassName:kEstimoteList];
    for (ESTBeacon *estBeacon in _beacons) {
        [query whereKey:kProximityUUID equalTo:estBeacon.proximityUUID.UUIDString];
        [query whereKey:kMajor equalTo:estBeacon.major];
        [query whereKey:kMinor equalTo:estBeacon.minor];
    }
    __weak EstimoteUtils *weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [weakSelf createResponse:objects];
    }];
}

- (void)createResponse:(NSArray *)objects {
    NSMutableArray *resultArray = objects.mutableCopy;
    for (ESTBeacon *estBeacon in _beacons) {
        BOOL beaconIsExist = NO;
        for (PFObject *pfObject in objects) {
            if ([pfObject[kProximityUUID] isEqualToString:estBeacon.proximityUUID.UUIDString] &&
                    [pfObject[kMajor] isEqual:estBeacon.major] &&
                    [pfObject[kMinor] isEqual:estBeacon.minor]) {
                beaconIsExist = YES;
            }
        }
        if (beaconIsExist == NO) {
            PFObject *estimote = [PFObject objectWithClassName:kEstimoteList];

            PFACL *acl = [PFACL ACL];
            [acl setPublicWriteAccess:YES];
            [acl setPublicReadAccess:YES];
            estimote.ACL = acl;

            estimote[kProximityUUID] = estBeacon.proximityUUID.UUIDString;
            estimote[kMajor] = estBeacon.major;
            estimote[kMinor] = estBeacon.minor;
            [estimote saveEventually];
            [resultArray addObject:estimote];
        }
    }
    if (EstimoteCallback)EstimoteCallback(resultArray);
}
@end