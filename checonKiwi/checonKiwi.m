#import "Kiwi.h"

SPEC_BEGIN(TestSpec)

describe(@"failure", ^{
    it(@"fails", ^{
        fail(@"failed");
    });
});

SPEC_END
