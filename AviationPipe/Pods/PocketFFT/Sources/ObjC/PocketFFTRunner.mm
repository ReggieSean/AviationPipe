#import "PocketFFTRunner.h"
#import "pocketfft.h"


@implementation PocketFFTRunner

+ (int)execute_dct:(double *)a1 result:(double *)resultArray dctType:(int)dctType inorm:(int)inorm cols:(int)cols rows:(int)rows {
    return execute_dct(a1, resultArray, dctType, inorm, cols, rows);
}

@end
